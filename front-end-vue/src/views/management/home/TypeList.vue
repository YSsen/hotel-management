<template>
  <div>
    <div class="list">
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
          prop="typeName"
          label="房型名称"
          width="230">
        </el-table-column>
        <el-table-column
          prop="typeNum"
          label="房间数量"
          width="120">
        </el-table-column>
        <el-table-column
          prop="price"
          label="房间价格"
          width="120">
          
          <template slot-scope="scope">
            <span style="margin-left: 10px">￥{{ scope.row.price }}</span>
          </template>
        </el-table-column>
        <el-table-column
          prop="deposit"
          label="需交押金"
          width="120">
          <template slot-scope="scope">
            <span style="margin-left: 10px">￥{{ scope.row.deposit }}</span>
          </template>
        </el-table-column>
        <el-table-column
          prop="typeBed"
          label="客房床型"
          width="180">
        </el-table-column>
        <el-table-column
          prop="area"
          label="房间面积"
          width="120"
        >
          <template slot-scope="scope">
            <span style="margin-left: 10px">{{ scope.row.area }}m<sup>2</sup></span>
          </template>
        </el-table-column>
        <el-table-column
          prop="tcNum"
          label="可住人数"
          width="120">
        </el-table-column>
        <el-table-column
          prop="floor"
          label="所在楼层"
          width="120">
        </el-table-column>
        <!-- <el-table-column
          prop="isDish"
          label="是否含早餐"
          width="140">
          <template slot-scope="scope">
            <span>{{scope.row.isDish?'提供':'不提供'}}</span>
          </template>
        </el-table-column> -->
        
        <el-table-column
          label="操作"
          width="100">
          <template slot-scope="scope">
            <el-button @click="editRow(scope.row)" type="text" size="small">编辑</el-button>
            <el-button @click="deleteRow(scope.row)" type="text" size="small">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      
      <!-- <el-pagination
        class="page"
        style="text-align: left;margin-top:20px;"
        background
        layout="total, prev, pager, next"
        :total="tableData.length"
      >
      </el-pagination> -->
      <div class="page">共{{tableData.length}}条</div>
    </div>


    <!-- 编辑 -->
    <el-dialog
      title="修改房型信息"
      class="dialog_div"
      :visible.sync="dialogVisible"
      width="40%"
    >
      <div slot="title" class="title">修改房型信息</div>

      <TypeAdd :isEdit="true" :info="rowData" ref="editForm"></TypeAdd>

      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitEdit">确 定 提 交</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {getAllRoomTypeList, deleteRoomType} from '@/api/roomType'

import TypeAdd from './TypeAdd.vue'
export default {
  name: 'roomsearch',
  components: { TypeAdd },
  data() {
    return {
      tableData: [
        // {
        //   price: 565,
        //   title: '1 张特大床, 城市景观, 客房',
        //   type: '1 张特大床',
        //   area: '20-25',
        //   count: 2,
        //   deposite: 800,
        //   floor: '14-15',
        //   money: 200,
        //   isDish: 1,
        //   num: 6
        // },{
        //   price: 565,
        //   title: '1 张特大床, 城市景观, 客房',
        //   type: '1 张特大床',
        //   area: '20-25',
        //   count: 2,
        //   deposite: 800,
        //   floor: '14-15',
        //   money: 200,
        //   isDish: 1,
        //   num: 6
        // },{
        //   price: 565,
        //   title: '1 张特大床, 城市景观, 客房',
        //   type: '1 张特大床',
        //   area: '20-25',
        //   count: 2,
        //   deposite: 800,
        //   floor: '14-15',
        //   money: 200,
        //   isDish: 1,
        //   num: 6
        // },{
        //   price: 565,
        //   title: '1 张特大床, 城市景观, 客房',
        //   type: '1 张特大床',
        //   area: '20-25',
        //   count: 2,
        //   deposite: 800,
        //   floor: '14-15',
        //   money: 200,
        //   isDish: 1,
        //   num: 6
        // },{
        //   price: 565,
        //   title: '1 张特大床, 城市景观, 客房',
        //   type: '1 张特大床',
        //   area: '20-25',
        //   count: 2,
        //   deposite: 800,
        //   floor: '14-15',
        //   money: 200,
        //   isDish: 1,
        //   num: 6
        // },{
        //   price: 565,
        //   title: '1 张特大床, 城市景观, 客房',
        //   type: '1 张特大床',
        //   area: '20-25',
        //   count: 2,
        //   deposite: 800,
        //   floor: '14-15',
        //   money: 200,
        //   isDish: 1,
        //   num: 6
        // },{
        //   price: 565,
        //   title: '1 张特大床, 城市景观, 客房',
        //   type: '1 张特大床',
        //   area: '20-25',
        //   count: 2,
        //   deposite: 800,
        //   floor: '14-15',
        //   money: 200,
        //   isDish: 1,
        //   num: 6
        // },{
        //   price: 565,
        //   title: '1 张特大床, 城市景观, 客房',
        //   type: '1 张特大床',
        //   area: '20-25',
        //   count: 2,
        //   deposite: 800,
        //   floor: '14-15',
        //   money: 200,
        //   isDish: 1,
        //   num: 6
        // },
      ],
      loading: true,
      form: {
        currentPage: 0,
        pageSize: 10
      },
      dialogVisible: false,
      rowData: null
    }
  },
  methods: {
    getDataList() {
      this.loading = true;
      getAllRoomTypeList().then(res => {
        this.tableData = res.data;
        this.loading = false;
      }).catch(() => {
        this.$message({
          message: '查询列表失败',
          type: 'error',
          duration:1000
        });
      });
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
        deleteRoomType(row.typeId).then((res) => {
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