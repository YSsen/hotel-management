<template>
  <div>
    <!-- 头部酒店说明 -->
    <div class="head">
      <div class="logo">
        <img src="@/assets/logo.png" alt="">
      </div>
      <div class="content">
        <div class="title"><span>伦兰唯尚酒店</span></div>
        <div class="info">
          <div>
            <i class="el-icon-location-outline"></i>
            <span>高新区全能大道1415号,南京,江苏 211100</span>
          </div>
          <div>
            <i class="el-icon-phone-outline"></i>
            <span>+86 25 8610 6888</span>
          </div>
          <div>
            <el-rate
              :value="4.5"
              disabled
              show-score
              :colors="['white','black','black']"
              text-color="black"
              score-template="4.5">
            </el-rate>
          </div>
        </div>
        <div class="des">
          <span>专属设施</span>
          <div>
            <i class="el-icon-key"></i>
            <span>手机钥匙</span>
          </div>
          <div>
            <i class="el-icon-dish"></i>
            <span>服务需求</span>
          </div>
          <div>
            <img src="@/assets/train.png" alt="">
            <span>健身</span>
          </div>
          <div>
            <img src="@/assets/wifi.png" alt="">
            <span>网络</span>
          </div>
        </div>
      </div>
    </div>
    <!-- 中间筛选条件 -->
    <div class="search">
      <div class="content">
        <span v-show="false">对结果进行筛选:</span>
        <el-checkbox-group v-model="checkboxGroup1" v-show="false">
          <el-checkbox-button :label="1">客房</el-checkbox-button>
          <el-checkbox-button :label="2">套房</el-checkbox-button>
          <el-checkbox-button :label="3">1张特大床</el-checkbox-button>
          <el-checkbox-button :label="4">2张单人床</el-checkbox-button>
        </el-checkbox-group>
        <el-button style="position: absolute;right: 0;" type="primary" @click="dialogVisible2 = true">预定结果查询</el-button>
      </div>
    </div>
    <!-- 客房列表 -->
    <div class="list" v-loading="loading">
      <div class="item" v-for="item,index in tableData" :key="index">
        <img :src="url+item.picture" alt="">
        <div class="content">
          <div class="title_info">
            <span class="title">{{item.typeName}}</span>
            <span class="price_info">房价￥<span class="price">{{item.price}}</span></span>
          </div>
          <div class="info">
            <div class="des">
              <div>床型:{{item.typeBed}}</div>
              <div>面积:{{item.area}}m<sup>2</sup></div>
              <div>可住人数:{{item.tcNum}}人</div>
              <div>楼层:{{item.floor}}楼</div>
              <div>押金:￥{{item.deposit}}</div>
              <div>包含自助早餐</div>
              <div>房间数量:{{item.typeNum}}</div>
            </div>
            <div class="btn">
              <el-button type="primary" @click="reserve(item)">预定</el-button>
            </div>
          </div>
        </div>
      </div>
      <el-pagination
        class="page"
        style="text-align: left;margin-top:20px;"
        background
        layout="total, prev, pager, next"
        :page-size="20"
        :total="tableData.length">
      </el-pagination>
    </div>

    <!-- 预定界面 -->
    <el-dialog
      title="客房预定"
      class="dialog_div"
      :visible.sync="dialogVisible"
      width="30%"
    >
      <div slot="title" class="title">客房预定</div>

      <el-form class="form_div" :rules="rules" ref="ruleForm" :model="form" label-width="100px">
        <el-form-item label="姓名" prop="name">
          <el-input
            v-model="form.name" placeholder="请输入姓名"
          ></el-input>
        </el-form-item>
        <!-- <el-form-item label="身份证号码" prop="cid">
          <el-input v-model="form.cid" placeholder="请输入身份证号码"></el-input>
        </el-form-item> -->
        <el-form-item label="入住人数" prop="rcNum">
          <el-input v-model="form.rcNum" placeholder="请输入入住人数"
          ></el-input>
        </el-form-item>
        <el-form-item label="入住日期" prop="inDate">
          <el-date-picker 
            type="date"
            placeholder="请选择入住日期"
            v-model="form.inDate"
            style="width: 100%;"
            value-format="yyyy-MM-dd"
          ></el-date-picker>
        </el-form-item>
        <el-form-item label="退房日期" prop="outDate">
          <el-date-picker 
            type="date" 
            placeholder="请选择退房日期" 
            v-model="form.outDate" 
            style="width: 100%;"
            value-format="yyyy-MM-dd"
          ></el-date-picker>
        </el-form-item>
        <el-form-item label="联系方式" prop="phone">
          <el-input v-model="form.phone" placeholder="请输入联系方式"></el-input>
        </el-form-item>
      </el-form>

      <div slot="footer" class="dialog-footer">
        <el-button type="primary" :loading="loading2" @click="submit">确 定 提 交</el-button>
      </div>
    </el-dialog>

    <!-- 预定结果查询界面 -->
    <el-dialog
      title="预定结果查询"
      class="dialog_div"
      :visible.sync="dialogVisible2"
      width="30%"
    >
      <div slot="title" class="title">预定结果查询</div>

      <el-form class="form_div" style="width:100%;" :inline="true" ref="ruleForm" :model="form2" label-width="100px">
        <el-form-item label="联系方式" prop="phone">
          <el-input v-model="form2.phone" placeholder="请输入联系方式"></el-input>
        </el-form-item>
        <el-form-item class="btn">
          <el-button type="primary" @click="searchInfo">查 询</el-button>
        </el-form-item>
      </el-form>

      <div class="info" v-if="info">
        <div>
          <h4>操作日期:</h4>
          <span>{{formatDate(info.createTime)}}</span>
        </div>
        <div>
          <h4>客户姓名:</h4>
          <span>{{info.name}}</span>
        </div>
        <div>
          <h4>预留手机号:</h4>
          <span>{{info.phone}}</span>
        </div>
        <div>
          <h4>入住人数:</h4>
          <span>{{info.rcNum}}</span>
        </div>
        <div>
          <h4>预定房型:</h4>
          <span>{{info.typeName}}</span>
        </div>
        <div>
          <h4>预定结果:</h4>
          <span>成功</span>
        </div>
        <div>
          <h4>预留门牌号:</h4>
          <span>{{info.roomNumber}}</span>
        </div>
        <div>
          <h4>入住日期:</h4>
          <span>{{formatDate(info.inDate)}}</span>
        </div>
      </div>
      <div v-else>
        暂无数据
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {getAllRoomTypeList} from '@/api/roomType'
import {reserve2} from '@/api/check'
import {getOrderInfo} from '@/api/order'
import {formatDateUtil} from '@/utils/date'

export default {
  name: 'reser',
  data() {
    return {
      tableData: [],
      url: process.env.VUE_APP_BASE_URL+'/upload/echo/',
      loading: false,

      checkboxGroup1: [1,2],
      form: {
        name: '',
        cid: '',
        rcNum: '',
        inDate: '',
        outDate: '',
        phone: ''
      },
      rules: {
        name: [
          { required: true, message: '请输入姓名', trigger: 'blur' }
        ],
        rcNum: [
          { required: true, message: '请输入入住人数', trigger: 'blur' }
        ],
        inDate: [
          { required: true, message: '请选择入住日期', trigger: 'blur' }
        ],
        outDate: [
          { required: true, message: '请选择退房日期', trigger: 'blur' }
        ],
        phone: [
          { required: true, message: '请输入联系方式', trigger: 'blur' }
        ]
      },
      loading2: false,
      roomTypeInfo: null,
      dialogVisible: false,
      dialogVisible2: false,
      form2: {
        phone: ''
      },
      info: null
    }
  },
  methods: {
    getDataList() {
      this.loading = true;
      getAllRoomTypeList().then(res => {
        this.tableData = res.data;
      }).catch(() => {
        this.$message({
          message: '查询列表失败',
          type: 'error',
          duration:1000
        });
      }).finally(() => {
        this.loading = false;
      });
    },

    reserve(row) {
      // 获取选择的房型数据
      this.roomTypeInfo = row;
      this.dialogVisible=true;
    },
    submit() {
      this.loading2 = true;
      this.$refs.ruleForm.validate((valid) => {
        if (valid) {
          let data = Object.assign(this.form);
          data.typeId = this.roomTypeInfo.typeId;
          data.typeName = this.roomTypeInfo.typeName;
          data.price = this.roomTypeInfo.price;
          reserve2(data).then(result => {
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
          });
        } else {
          this.$message({
            message: '请完善表单',
            type: 'error',
            duration:1000
          });
          this.loading2 = false;
        }
      });
    },

    searchInfo() {
      if (this.form2.phone.trim()) {
        getOrderInfo(this.form2.phone).then(res => {
          this.info = res.data;
        }).catch(() => {
          this.$message({
            message: '查询失败',
            type: 'error',
            duration:1000
          });
        });
      }
    },
    formatDate(val) {
      let date = new Date(val);
      return formatDateUtil(date);
    },
  },
  created() {
    this.getDataList();
    // 
  },
  beforeCreate() {
    // 获取到前面打过标签的元素，将其scrollTop属性设置为0
    document.documentElement.scrollTop = 0
    // 滚动条可能出现在HTML元素上而不是body上，确保兼容性，同时将HTML和body中scrollTop属性设置为0
    document.body.scrollTop = 0
  },
}
</script>

<style lang="scss" scoped>
.head {
  display: flex;
  align-items: center;
  width: 1200px;
  margin: auto;
  padding: 40px 0;
  .content {
    margin-left: 20px;
    display: flex;
    align-items: flex-start;
    flex-direction: column;
    row-gap: 24px;
    font-size: 18px;
    .title, .info, .des {
      display: flex;
    }
    .title {
      letter-spacing: 2px;
      font-size: 32px;
      font-weight: bold;
    }
    .info {
      gap: 35px;
      justify-content: center;
      i {
        font-weight: bold;
        font-size: 20px;
      }
    }
    .des {
      gap: 35px;
      justify-content: center;
      i {
        font-weight: bold;
        font-size: 20px;
        margin-right: 4px;
      }
      img {
        width: 20px;
        margin-right: 4px;
      }
    }
  }
}
.search {
  box-shadow: 0 1px 1px #d2d2d2;
  .content {
    display: flex;
    align-items: center;
    width: 1200px;
    margin: auto;
    position: relative;
    span {
      margin-right: 20px;
      font-size: 32px;
    }
  }
}
.list {
  width: 1300px;
  margin: auto;
  padding: 40px 0;
  .item {
    display: flex;
    margin: 10px;
    img {
      width: 270px;
      object-fit: cover;
    }
    .content {
      width: 100%;
      .title_info {
        display: flex;
        justify-content: space-between;
        font-size: 24px;
        text-align: left;
        padding-left: 40px;
        margin-bottom: 40px;
        .title {
          color: #d6876e;
        }
      }
      .price_info {
        font-size: 18px;
        text-align: right;
        .price {
          color: #d6876e;
        }
      }
      .info {
        position: relative;
        .des {
          text-align: left;
          padding: 0 80px;
          font-size: 18px;
          display: grid;
          grid-template-columns: repeat(3, 33%);
          grid-template-rows: repeat(3, 50px);
        }
        .btn {
          display: flex;
          position: absolute;
          top: 20px;
          right: 0;
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
    margin: auto;
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
        width: 100px;
        text-align: left;
      }
    }
  }
}
</style>
<style lang="scss">
.search {
  .content {
    .el-checkbox-button__inner {
      font-size: 20px;
    }
    .el-button--primary {
      font-size: 18px;
    }
  }
}
.list {
  .page {
    .el-pagination__total {
      font-size: 16px;
    }
  }
  .info {
    .btn {
      .el-button--primary {
        background: #d6876e;
        border-color: #d6876e;
        font-size: 18px;
      }
      .el-button--primary:hover {
        opacity: 0.8;
      }
      .el-button--primary:active {
        opacity: 1;
      }
    }
  }
}
.dialog_div {
  .form_div {
    .el-form-item__label {
      font-size: 18px;
    }
    .el-form-item {
      margin-bottom: 40px;
    }
  }
  .dialog-footer {
      .el-button--primary {
        background: #d6876e;
        border-color: #d6876e;
        font-size: 18px;
      }
      .el-button--primary:hover {
        opacity: 0.8;
      }
      .el-button--primary:active {
        opacity: 1;
      }
  }
}
</style>