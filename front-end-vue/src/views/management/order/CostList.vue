<template>
  <div>
    <div class="list">
      <el-form class="form_div" style="width:100%;" :inline="true" :model="form" label-width="100px">
        <el-form-item label="房间门牌号" prop="roomNumber">
          <el-input v-model="form.roomNumber" placeholder="请输入房间门牌号" clearable></el-input>
        </el-form-item>
        <el-form-item label="联系方式" prop="phone">
          <el-input v-model="form.phone" placeholder="请输入联系方式" clearable></el-input>
        </el-form-item>
        <el-form-item class="btn">
          <el-button type="primary" @click="search">查 询</el-button>
        </el-form-item>
      </el-form>

      <el-table
        v-loading="loading"
        :data="tableData"
        style="width: 100%"
      >
        <el-table-column
          prop="orderId"
          label="消费记录单号"
          width="130">
        </el-table-column>
        <el-table-column
          prop="roomNumber"
          label="房间门牌号"
          width="120">
        </el-table-column>
        <el-table-column
          prop="name"
          label="客户姓名"
          width="120">
        </el-table-column>
        <el-table-column
          prop="phone"
          label="联系方式"
          width="180">
        </el-table-column>
        <el-table-column
          prop="cid"
          label="客户身份证号"
          width="180">
        </el-table-column>
        <el-table-column
          prop="inDate"
          label="开房时间"
          :formatter="formatDate"
          width="180">
        </el-table-column>
        <el-table-column
          prop="outDate"
          label="退房时间"
          width="180"
          :formatter="formatDate"
        >
        </el-table-column>
        <el-table-column
          prop="price"
          label="房间价格"
          width="120">
        </el-table-column>
        <el-table-column
          prop="orderCost"
          label="消费金额"
          width="120">
        </el-table-column>
        
        <el-table-column
          label="操作"
          width="100">
          <template slot-scope="scope">
            <el-button type="text" size="small" @click="deleteOrder(scope.row)">删除</el-button>
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
  </div>
</template>

<script>
import {getOrderList, deleteOrder} from '@/api/order'

export default {
  name: 'OrderList',
  data() {
    return {
      loading: true,
      form: {
        roomNumber: '',
        phone: '',
        page: 1,
        limit: 10
      },
      curPage: 1,
      total: 0,
      tableData: []
    }
  },
  methods: {
    getDataList() {
      this.loading = true;
      let data = Object.assign(this.form);
      data.page = this.curPage-1;
      if (!this.form.roomNumber) delete data.roomNumber;
      if (!this.form.phone) delete data.phone;
      getOrderList(data).then(res => {
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
    search() {
      this.curPage = 1;
      this.getDataList();
    },
    deleteOrder(row) {
      this.$confirm('确认删除?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteOrder(row.orderId).then((res) => {
          if (res.data) {
            this.$message({
              message: '删除成功',
              type: 'success',
              duration:1000
            });
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
    changePage() {
      this.getDataList();
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
</style>