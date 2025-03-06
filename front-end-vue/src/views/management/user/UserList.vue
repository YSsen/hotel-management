<template>
  <div>
    <div class="list">
      <el-table
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
          prop="name"
          label="用户昵称"
          width="140">
        </el-table-column>
        <el-table-column
          prop="username"
          label="用户账号"
          width="140">
        </el-table-column>
        <el-table-column
          prop="role"
          label="所属角色"
          :formatter="formatRole"
          width="140">
        </el-table-column>
        <el-table-column
          prop="phone"
          label="联系电话"
          width="140">
        </el-table-column>
        <el-table-column
          prop="createTime"
          label="创建日期"
          :formatter="formatDate"
          width="140">
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
      title="修改用户信息"
      class="dialog_div"
      :visible.sync="dialogVisible"
      width="40%"
    >
      <div slot="title" class="title">修改用户信息</div>

      <UserAdd :isEdit="true" :info="rowData" ref="editForm"></UserAdd>

      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitEdit">确 定 提 交</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {getUserList, deleteUser} from '@/api/user'
import UserAdd from './UserAdd.vue'
export default {
  name: 'roomsearch',
  components: { UserAdd },
  data() {
    return {
      tableData: [],
      form: {
        page: 1,
        limit: 10
      },
      curPage: 1,
      loading: true,
      total: 0,
      rowData: null,
      dialogVisible: false,
    }
  },
  methods: {
    getDataList() {
      this.loading = true;
      let data = Object.assign(this.form);
      data.page = this.curPage-1;
      getUserList(data).then(res => {
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
    formatDate(row, column) {
      let date = new Date(row[column.property]);
      return this.formatDateUtil(date);
    },
    formatDateUtil(date) {
      var year = date.getFullYear();
      var month = this.addZero(date.getMonth() + 1);
      var day = this.addZero(date.getDate());
      return year + '-' + month + '-' + day;
    },
    addZero(num) {
      return num < 10 ? '0' + num : num;
    },
    formatRole(row) {
      if (row.role == 'operator') {
        return '工作人员';
      } else return '管理员'
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
        deleteUser(row.workerId).then((res) => {
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
    this.getDataList();
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