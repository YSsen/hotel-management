<template>
  <div>
    <!-- 首航 -->
    <div class="search">
      <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal" @select="handleSelect">
        <!-- <el-menu-item index="1">空房可住</el-menu-item>
        <el-menu-item index="2">预定中</el-menu-item>
        <el-menu-item index="3">已入住</el-menu-item> -->
        <el-menu-item v-for="item in roomStatusList" :key="item.key" :index="String(item.key)">{{item.value}}</el-menu-item>
      </el-menu>
    </div>
    <!-- 卡片列表 -->
    <div class="list">
      <!-- 筛选 -->
      <div class="filter">
        <el-form class="form_div" style="width:100%;" :inline="true" ref="searchForm" :model="form" label-width="100px">
          <el-form-item label="房间类型" prop="typeId" class="wid">
            <el-select
              v-model="form.typeId" 
              placeholder="请选择房间类型" 
              style="width: 100%;"
              clearable
            >
              <el-option
                v-for="item in roomTypeList"
                :key="item.typeId"
                :label="item.typeName"
                :value="item.typeId">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="联系方式" prop="phone">
            <el-input v-model="form.phone" placeholder="请输入联系方式"></el-input>
          </el-form-item>
          <el-form-item class="btn">
            <el-button type="primary" @click="search">查 询</el-button>
          </el-form-item>
        </el-form>
      </div>

      <div class="content" v-loading="loading">
        <template v-if="tableData.length>0">
          <div class="card" v-for="(item, index) in tableData" :key="index">
            <div class="pic">
              <img src="@/assets/bed.png" alt="">
            </div>
            <div class="info">
              <span>{{item.roomNumber}}</span>
              <span>{{item.typeBed}}</span>
              <span>{{item.price}}/天</span>
            </div>
            <div class="btn">
              <a class="b1" @click="checkIn(item)" v-show="form.roomStatus=='1'">开房</a>
              <a class="b2" @click="reserve(item)" v-show="form.roomStatus=='1'">预定</a>
              <a class="b3" @click="changeRoom(item)" v-show="form.roomStatus=='3'">换房</a>
              <a class="b4" @click="checkOut(item)" v-show="form.roomStatus=='3'">退房</a>
              <!-- 预定后入住（开房） -->
              <a class="b1" @click="checkIn2(item)" v-show="form.roomStatus=='2'">入住</a>
              <!-- 取消预定 -->
              <a class="b4" @click="deleteReserve(item)" v-show="form.roomStatus=='2'">退房</a>
            </div>
          </div>
        </template>
        <template v-else>
          <div style="text-align:center;">
            暂无数据
          </div>
        </template>
      </div>
      <el-pagination
        class="page"
        style="text-align: left;margin-top:20px;"
        background
        layout="total, prev, pager, next"
        :total="total"
        :page-size="form.limit"
        :current-page.sync="curPage"
        @current-change="changePage"
      >
      </el-pagination>
    </div>

    <!-- 开房操作 -->
    <el-dialog
      :title="title"
      class="dialog_div"
      :visible.sync="dialogVisible"
      width="40%"
    >
      <div slot="title" class="title">{{title}}</div>

      <el-form class="form_div" :rules="rules" ref="ruleForm" :model="form2" label-width="120px">
        <el-form-item label="房间门牌号" prop="roomNumber" >
          <el-input
            v-model="form2.roomNumber" placeholder="请输入房间门牌号" disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="所在楼层" prop="floor" >
          <el-input type="number" v-model="form2.floor" placeholder="请输入所在楼层" disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="房间类型" prop="typeId" >
          <el-select
            v-model="form2.typeId" 
            placeholder="请选择房间类型" 
            style="width: 100%;"
            disabled
          >
            <el-option
              v-for="item in roomTypeList"
              :key="item.typeId"
              :label="item.typeName"
              :value="item.typeId">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="房间价格" prop="price" >
          <el-input v-model="form2.price" placeholder="请输入房间价格" disabled></el-input>
        </el-form-item>
        <el-form-item label="需交押金" prop="deposit" >
          <el-input v-model="form2.deposit" placeholder="请输入需交押金" disabled></el-input>
        </el-form-item>
        <el-form-item label="客房床型" prop="typeBed" >
          <el-input v-model="form2.typeBed" placeholder="请输入客房床型" disabled>
          </el-input>
        </el-form-item>
        <el-form-item label="客户姓名" prop="name">
          <el-input v-model="form2.name" placeholder="请输入客户姓名"></el-input>
        </el-form-item>
        <el-form-item label="身份证号码" prop="cid">
          <el-input v-model="form2.cid" placeholder="请输入身份证号码"></el-input>
        </el-form-item>
        <el-form-item label="联系方式" prop="phone">
          <el-input v-model="form2.phone" placeholder="请输入联系方式"></el-input>
        </el-form-item>
        <el-form-item label="入住人数" prop="rcNum">
          <el-input v-model="form2.rcNum" placeholder="请输入可住人数"></el-input>
        </el-form-item>
        <el-form-item label="入住日期" prop="inDate" v-show="operType==2">
          <el-date-picker 
            type="date"
            placeholder="请选择入住日期"
            v-model="form2.inDate"
            style="width: 100%;"
            value-format="yyyy-MM-dd"
          ></el-date-picker>
        </el-form-item>
        <el-form-item label="退房日期" prop="outDate" v-show="operType==2">
          <el-date-picker 
            type="date" 
            placeholder="请选择退房日期" 
            v-model="form2.outDate" 
            style="width: 100%;"
            value-format="yyyy-MM-dd"
          ></el-date-picker>
        </el-form-item>
      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button type="primary" :loading="loading2" @click="submit">确 定 提 交</el-button>
      </div>
    </el-dialog>


    
    <!-- 换房操作 -->
    <el-dialog
      title="换房操作"
      class="dialog_div"
      :visible.sync="dialogVisible2"
      width="60%"
    >
      <div slot="title" class="title">换房操作</div>

      <ChangeRoom v-if="dialogVisible2" :roomTypeList="roomTypeList" :selectedRow="selectedRow" @changed="changedRoom"></ChangeRoom>

      <div slot="footer" class="dialog-footer">
      </div>
    </el-dialog>

  </div>
</template>

<script>
import {ROOM_STATUS} from '@/utils/constant'
import {getAllRoomTypeList} from '@/api/roomType'
import {getRoomList2} from '@/api/room'
import {reserve, checkIn, getReservation, checkOut, cancelReserve} from '@/api/check'
import ChangeRoom from './ChangeRoom'

export default {
  name: 'checkin',
  components: {ChangeRoom},
  data() {
    return {
      activeIndex: '1',
      checkboxGroup1: [1,2],
      tableData: [],
      loading: true,
      form: {
        roomStatus: '1',
        typeId: '',
        phone: '',
        page: 1,
        limit: 20
      },
      curPage: 1,
      total: 0,
      dialogVisible: false,
      roomTypeList: [],
      rowData: null,
      roomStatusList: ROOM_STATUS,

      // 开房表单
      // 1：开房、2：预定、3：换房、4：退房、5：取消预定
      operType: 1,
      title: '开房操作',
      form2: {
        roomNumber: '',
        floor: '', 
        typeId: '',
        price: '', 
        deposit: '', 
        typeBed: '',
        name: '',
        cid: '',
        phone: '',
        rcNum: '',
        inDate: '',
        outDate: ''
      },
      rules: {
        name: [
          { required: true, message: '请输入客户姓名', trigger: 'blur' }
        ],
        cid: [
          { required: true, message: '请输入身份证号码', trigger: 'blur' }
        ],
        rcNum: [
          { required: true, message: '请输入入住人数', trigger: 'blur' }
        ],
        inDate: [
          { required: true, message: '请选择入住日期', trigger: 'change' }
        ],
        outDate: [
          { required: true, message: '请选择退房日期', trigger: 'change' }
        ],
        phone: [
          { required: true, message: '请输入联系方式', trigger: 'blur' }
        ]
      },
      selectedRow: null,
      loading2: false,

      // 换房
      dialogVisible2: false,
    }
  },
  methods: {
    getRoomTypeList() {
      getAllRoomTypeList().then(res => {
        this.roomTypeList = res.data;
      }).catch(() => {
        this.$message({
          message: '获取房间类型失败，请刷新页面重新获取',
          type: 'error',
          duration:1000
        });
      });
    },
    getDataList() {
      this.loading = true;
      let data = Object.assign(this.form);
      data.page = this.curPage-1;
      if (!this.form.roomStatus) delete data.roomStatus;
      if (!this.form.typeId) delete data.typeId;
      if (!this.form.phone) delete data.phone;
      getRoomList2(data).then(res => {
        this.tableData = res.data.content;
        this.total = res.data.total;
        this.loading = false;
      }).catch(() => {
        this.$message({
          message: '查询列表失败',
          type: 'error',
          duration:1000
        });
      });
    },
    handleSelect(val) {
      this.$refs.searchForm.resetFields();
      this.form.roomStatus = val;
      this.getDataList();
    },
    changePage() {
      this.getDataList();
    },
    search() {
      this.curPage = 1;
      this.getDataList();
    },

    // 处理信息，展示弹窗
    showRowInfo(row) {
      this.form2.roomNumber = row.roomNumber;
      this.form2.floor = row.floor;
      this.form2.typeId = row.typeId;
      this.form2.price = row.price;
      this.form2.deposit = row.deposit;
      this.form2.typeBed = row.typeBed;
    },
    // 开房
    checkIn(row) {
      this.selectedRow = row;
      this.operType = 1;
      this.title = '开房操作';
      // 处理信息，展示到开房页面
      this.showRowInfo(row);
      // 展示预定弹窗
      this.dialogVisible = true;
    },
    // 入住
    checkIn2(row) {
      // 要回显预定的信息，需要查询订单信息
      getReservation(row.roomId).then(res => {
        // 再调用checkIn方法，执行相关事务
        this.form2.name = res.data.name;
        this.form2.cid = res.data.cid;
        this.form2.phone = res.data.phone;
        this.form2.rcNum = res.data.rcNum;
        this.form2.inDate = res.data.inDate;
        this.form2.outDate = res.data.outDate;
        this.checkIn(row);
      }).catch(() => {
        this.$message({
          message: '获取预定信息失败，请重试',
          type: 'error',
          duration:1000
        });
      });
    },
    // 预定
    reserve(row) {
      this.selectedRow = row;
      this.operType = 2;
      this.title = '预定操作';
      // 处理信息，展示到预定页面
      this.showRowInfo(row);
      // 展示预定弹窗
      this.dialogVisible = true;
    },
    // 换房
    changeRoom(row) {
      this.selectedRow = row;
      this.dialogVisible2 = true;
    },
    // 换房后
    changedRoom() {
      this.dialogVisible2 = false;
      this.search();
    },
    // 退房
    checkOut(row) {
      // this.selectedRow = row;
      // this.operType = 4;
      // this.title = '退房操作';
      // // 处理信息，展示到预定页面
      // this.showRowInfo(row);
      // // 展示预定弹窗
      // this.dialogVisible = true;
      
      this.$confirm('确认退房?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        checkOut(row.roomId).then((res) => {
          if (res.data) {
            this.$message({
              message: '退房成功',
              type: 'success',
              duration:1000
            });
          } else {
            this.$message({
              message: '退房失败',
              type: 'error',
              duration:1000
            });
          }
        }).finally(() => {
          this.search();
        });
      });
    },
    // 取消预定
    deleteReserve(row) {
      this.$confirm('确认退房?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        cancelReserve(row.roomId).then((res) => {
          if (res.data) {
            this.$message({
              message: '退房成功',
              type: 'success',
              duration:1000
            });
          } else {
            this.$message({
              message: '退房失败',
              type: 'error',
              duration:1000
            });
          }
        }).finally(() => {
          this.search();
        });
      });
    },
    getTypeName(val) {
      let typeName = this.roomTypeList.find(item => item.typeId == val).typeName;
      return typeName;
    },

    // 提交
    submit() {

      this.loading2 = true;
      this.$refs.ruleForm.validate((valid) => {
        if (valid) {
          let data = Object.assign(this.form2);
          delete data.floor;
          // 根据typeId获取typeName
          data.typeName = this.getTypeName(this.form2.typeId);
          delete data.typeId;
          data.roomId = this.selectedRow.roomId;
          // 开房
          if (this.operType == 1) {
            // 开房的入住日期为今天, 开房的退房日期暂无，直到退房操作时才生成
            data.inDate = new Date();

            checkIn(data).then(result => {
              if (result) {
                this.$message({
                  message: '入住成功',
                  type: 'success',
                  duration:1000
                });
                this.$refs.ruleForm.resetFields();
              }
            }).catch(() => {
              this.$message({
                message: '开房失败',
                type: 'error',
                duration:1000
              });
            }).finally(() => {
              this.dialogVisible = false;
              this.loading2 = false;
              this.search();
            });
          }
          // 预定
          else if (this.operType == 2) {
            reserve(data).then(result => {
              if (result) {
                this.$message({
                  message: '预定成功',
                  type: 'success',
                  duration:1000
                });
                this.$refs.ruleForm.resetFields();
              }
            }).catch(() => {
              this.$message({
                message: '预定失败',
                type: 'error',
                duration:1000
              });
            }).finally(() => {
              this.dialogVisible = false;
              this.loading2 = false;
              this.search();
            });
          }
        } else {
          this.$message({
            message: '请完善表单',
            type: 'error',
            duration:1000
          });
          this.loading2 = false;
        }
      });
    }
  },
  created() {
    this.getRoomTypeList();
    this.getDataList();
  }
}
</script>

<style lang="scss" scoped>
.search {
  padding: 40px;
  padding-bottom: 0;
}
.list {
  padding: 40px;
  .filter {
    margin: 40px;
  }
  .content {
    display: grid;
    grid-template-columns: repeat(5, 20%);
    grid-row-gap: 40px;
    .card {
      display: flex;
      width: 160px;
      height: 170px;
      place-self: center;
      flex-direction: column;
      gap: 6px;
      border: 1px solid #1296db;
      border-radius: 24px;
      box-shadow: 0 0 3px #1296db;
      .info {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        padding: 0 20px;
        gap: 4px;
        font-size: 14px;
        :nth-child(1) {
          color: #1296db;
          font-weight: bold;
        }
      }
      .btn {
        font-weight: bold;
        font-size: 14px;
        margin-top: 6px;
        display: flex;
        justify-content: space-between;
        padding: 0 20px;
        a:hover {
          box-shadow: 0 1px;
        }
        .b1 {
          color: #1296db;
        }
        .b2 {
          color: #f56c6c;
        }
        .b3 {
          color: #1296db;
        }
        .b4 {
          color: #f56c6c;
        }
      }
    }
  }
}


.dialog_div {
  .title {
    color: #d6876e;
    font-size: 32px;
  }
  .form_div {
    width: 60%;
    overflow-y: scroll;
    height: 500px;
    width: 100%;
    padding: 0 10%;
  }
  .dialog-footer {
    text-align: center;
    margin-bottom: 20px;
  }
  .info {
    width: 500px;
    margin: auto;
    background: #f1e8e8;
    border-top: 4px solid #cfb8b8;
    font-size: 18px;
    padding-left: 40px;
    div {
      display: flex;
      align-items: center;
      gap: 20px;
      h4 {
        margin: 10px;
      }
    }
  }
}
</style>
<style lang="scss">
.wid {
  .el-form-item__content {
    width:300px;
  }
}
.dialog_div {
  .form_div {
    .el-form-item {
      .el-select {
        width: 100%;
      }
    }
  }
}
</style>