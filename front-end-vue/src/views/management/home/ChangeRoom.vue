<template>
  <div>
    <!-- 卡片列表 -->
    <div class="list">
      <!-- 筛选 -->
      <div class="filter">
        <el-form class="form_div3" style="width:100%;" :inline="true" ref="searchForm" :model="form" label-width="100px">
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
              <a class="b3" @click="change(item)">换房</a>
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
        style="text-align: left;margin-top:40px;"
        background
        layout="total, prev, pager, next"
        :total="total"
        :page-size="form.limit"
        :current-page.sync="curPage"
        @current-change="changePage"
      >
      </el-pagination>
    </div>

  </div>
</template>

<script>
import {getRoomList2} from '@/api/room'
import {changeRoom} from '@/api/check'
export default {
  name: 'changeRoom',
  props: {
    roomTypeList: {
      type: Array,
      default: null
    },
    selectedRow: {
      type: Object,
      default: null
    }
  },
  data() {
    return {
      tableData: [],
      loading: true,
      form: {
        roomStatus: '1',
        typeId: '',
        page: 1,
        limit: 10
      },
      curPage: 1,
      total: 0,

      // 换房
      dialogVisible2: false,
    }
  },
  methods: {
    getDataList() {
      this.loading = true;
      let data = Object.assign(this.form);
      data.page = this.curPage-1;
      if (!this.form.typeId) delete data.typeId;
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
    changePage() {
      this.getDataList();
    },
    search() {
      this.curPage = 1;
      this.getDataList();
    },

    getTypeName(val) {
      let typeName = this.roomTypeList.find(item => item.typeId == val).typeName;
      return typeName;
    },

    change(item) {
      this.$confirm('确认换房?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.submit(item);
      });
    },
    // 提交
    submit(item) {
      let data = {
        oldRoomId: this.selectedRow.roomId,
        roomId: item.roomId,
        roomNumber: item.roomNumber,
        price: item.price
      }
      // 根据typeId获取typeName
      data.typeName = this.getTypeName(item.typeId);
      // 换房
      changeRoom(data).then(result => {
        if (result) {
          this.$message({
            message: '换房成功',
            type: 'success',
            duration:1000
          });
        }
      }).catch(() => {
        this.$message({
          message: '换房失败',
          type: 'error',
          duration:1000
        });
      }).finally(() => {
        this.$emit('changed');
      });
    }
  },
  created() {
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
  .form_div3 {
    width: 100%;
    padding: 0 10%;
  }
  .dialog-footer {
    text-align: center;
    margin-bottom: 20px;
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
  .form_div3 {
    .el-form-item {
      .el-select {
        width: 100%;
      }
    }
  }
}
</style>