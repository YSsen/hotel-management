<template>
  <div>
    <div class="list">
      <el-form class="form_div" style="width:100%;" :inline="true" :model="form" label-width="100px">
        <el-form-item label="房间类型" prop="typeId">
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
        <el-form-item label="房间状态" prop="roomStatus">
          <el-select
            v-model="form.roomStatus" 
            placeholder="请选择房间状态" 
            style="width: 100%;"
            clearable
          >
            <el-option
              v-for="item in roomStatusList"
              :key="item.key"
              :label="item.value"
              :value="item.key">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item class="btn">
          <el-button type="primary" @click="search">查 询</el-button>
        </el-form-item>
      </el-form>

      <el-table
        ref="singleTable"
        v-loading="loading"
        :data="tableData"
        style="width: 100%"
      >
        <el-table-column
          type="index"  
          label="序号"
          width="70">
          <template slot-scope="scope">
            {{ scope.$index+1 }}
          </template>
        </el-table-column>
        <el-table-column
          prop="roomNumber"
          label="房间门牌号"
          width="110">
        </el-table-column>
        <el-table-column
          prop="typeId"
          label="房间类型"
          width="230">
          <template slot-scope="scope">
            <span style="margin-left: 10px">{{ formateRoomType(scope.row.typeId) }}</span>
          </template>
        </el-table-column>
        <el-table-column
          prop="roomStatus"
          label="房间状态"
          width="120">
          <template slot-scope="scope">
            <span style="margin-left: 10px">{{ formateRoomStatus(scope.row.roomStatus) }}</span>
          </template>
        </el-table-column>
        <el-table-column
          prop="floor"
          label="所在楼层"
          width="120">
        </el-table-column>

        <el-table-column
          label="操作"
          width="100">
          <template slot-scope="scope">
            <el-button @click="editRow(scope.row)" type="text" size="small">编辑</el-button>
            <el-button @click="deleteRow(scope.row)" type="text" size="small">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      
      <el-pagination
        class="page"
        style="text-align: left;margin-top:20px;"
        background
        layout="total, prev, pager, next"
        :total="total"
        :current-page.sync="curPage"
        @current-change="changePage"
      >
      </el-pagination>
    </div>

    <!-- 编辑 -->
    <el-dialog
      title="修改房间信息"
      class="dialog_div"
      :visible.sync="dialogVisible"
      width="40%"
    >
      <div slot="title" class="title">修改房间信息</div>

      <RoomAdd :isEdit="true" :info="rowData" ref="editForm"></RoomAdd>

      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitEdit">确 定 提 交</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {getAllRoomTypeList} from '@/api/roomType'
import {getRoomList, deleteRoom} from '@/api/room'
import {ROOM_STATUS} from '@/utils/constant'
import RoomAdd from './RoomAdd.vue'

export default {
  name: 'roomsearch',
  components: { RoomAdd },
  data() {
    return {
      tableData: [
      ],
      loading: true,
      form: {
        roomStatus: '',
        typeId: '',
        page: 1,
        limit: 10
      },
      curPage: 1,
      total: 0,
      dialogVisible: false,
      roomTypeList: [],
      rowData: null,
      roomStatusList: ROOM_STATUS
    }
  },
  methods: {
    getRoomTypeList() {
      getAllRoomTypeList().then(res => {
        this.roomTypeList = res.data;
        this.getDataList();
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
      getRoomList(data).then(res => {
        this.tableData = res.data.content;
        this.total = res.data.total;
        this.loading = false;

        // 删除当前页最后一项的分页问题
        if ((!this.tableData || this.tableData.length == 0) && this.curPage > 1) {
          this.curPage = this.curPage - 1;
          this.getDataList();
        }
      }).catch(() => {
        this.$message({
          message: '查询列表失败',
          type: 'error',
          duration:1000
        });
      });
    },
    formateRoomStatus(status) {
      try {
        return this.roomStatusList.find(item => item.key == status).value;
      } catch (error) {
        return '——';
      }
    },
    formateRoomType(typeId) {
      try {
        return this.roomTypeList.find(item => item.typeId == typeId).typeName;
      } catch (error) {
        return '——';
      }
    },
    changePage() {
      this.getDataList();
    },
    search() {
      this.curPage = 1;
      this.getDataList();
    },

    editRow(row) {
      this.rowData = row;
      this.dialogVisible = true;
    },
    deleteRow(row) {
      this.$confirm('确认删除?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteRoom(row.roomId).then((res) => {
          if (res.data) {
            this.$message({
              message: '删除成功',
              type: 'success',
              duration:1000
            });
            this.rowData = null;
            this.getDataList();
          } else {
            this.$message({
              message: '删除失败',
              type: 'error',
              duration:1000
            });
          }
        });
      });
    },

    submitEdit() {
      this.$refs.editForm.submit((res) => {
        if (res.data) {
          this.$message({
            message: '编辑成功',
            type: 'success',
            duration:1000
          });
          this.dialogVisible = false;
          this.rowData = null;
          this.getDataList();
        } else {
          this.$message({
            message: '编辑失败',
            type: 'error',
            duration:1000
          });
        }
      });
    }
  },
  created() {
    this.getRoomTypeList();
  }
}
</script>

<style lang="scss" scoped>
.list {
  padding: 40px;
}
.page {
  text-align: left;
    padding: 20px 0;
    font-size: 16px;
    letter-spacing: 2px;
}

.dialog_div {
  .title {
    font-size: 24px;
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

.dialog_div {
  .form_div {
    width: 100%;
    .el-form-item__label {
      font-size: 18px;
    }
    .el-form-item {
      margin-bottom: 40px;
    }
  }
  // .dialog-footer {
  //     .el-button--primary {
  //       background: #d6876e;
  //       border-color: #d6876e;
  //       font-size: 18px;
  //     }
  //     .el-button--primary:hover {
  //       opacity: 0.8;
  //     }
  //     .el-button--primary:active {
  //       opacity: 1;
  //     }
  // }
}
</style>