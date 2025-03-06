<template>
  <div>
    <div class="search">
      <el-form class="form_div" style="width:100%;" :inline="true" ref="ruleForm" :model="form" label-width="100px">
        <el-form-item label="房间号" prop="roomNumber">
          <el-input v-model="form.roomNumber" placeholder="请输入房间号"></el-input>
        </el-form-item>
        <el-form-item label="联系方式" prop="phone">
          <el-input v-model="form.phone" placeholder="请输入联系方式"></el-input>
        </el-form-item>
        <el-form-item class="btn">
          <el-button type="primary" @click="1+1">查 询</el-button>
        </el-form-item>
      </el-form>
    </div>
    <div class="list">
      <el-table
        :data="tableData"
        style="width: 100%"
      >
        <el-table-column
          prop="door_id"
          label="房间门牌号"
          width="180">
        </el-table-column>
        <el-table-column
          prop="name"
          label="客户姓名"
          width="180">
        </el-table-column>
        <el-table-column
          prop="start"
          label="开房时间"
          width="180">
        </el-table-column>
        <el-table-column
          prop="title"
          label="房间类型"
          width="330">
        </el-table-column>
        <el-table-column
          prop="price"
          label="房间价格"
          width="180">
        </el-table-column>
        <el-table-column
          prop="id_p"
          label="客户身份证号"
          width="180">
        </el-table-column>
      </el-table>
      
      <el-pagination
        class="page"
        style="text-align: left;margin-top:20px;"
        background
        layout="total, prev, pager, next"
        :page-size="10"
        :total="tableData.length"
      >
      </el-pagination>
    </div>
  </div>
</template>

<script>
import {getRoomList2} from '@/api/room'

export default {
  name: 'roomsearch',
  data() {
    return {
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
    }
  },
  methods: {
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
  }
}
</script>

<style lang="scss" scoped>
.search {
  padding-top: 40px;
}
.list {
  padding: 40px;
}
</style>