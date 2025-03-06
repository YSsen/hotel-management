<template>
  <div>
    <el-form class="form_div" :rules="rules" ref="ruleForm" :model="form" label-width="120px">
      <el-form-item label="房间门牌号" prop="roomNumber">
        <el-input
          v-model="form.roomNumber" placeholder="请输入房间门牌号" @keyup.enter.native="submit"
        ></el-input>
      </el-form-item>
      <el-form-item label="房间类型" prop="typeId">
        <el-select
          v-model="form.typeId" 
          placeholder="请选择房间类型" 
          style="width: 100%;"
          @change="selectRoomType"
        >
          <el-option
            v-for="item in roomTypeList"
            :key="item.typeId"
            :label="item.typeName"
            :value="item.typeId">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="所在楼层" prop="floor">
        <el-input v-model="form.floor" :placeholder="placeholder" ref="floor" @keyup.enter.native="submit"></el-input>
      </el-form-item>
    </el-form>
    <div class="footer" v-show="!isEdit">
      <el-button type="primary" :loading="loading" @click="submit">确 定 提 交</el-button>
    </div>
  </div>
</template>

<script>
import {getAllRoomTypeList} from '@/api/roomType'
import {addRoom, editRoom} from '@/api/room'
export default {
  name: 'typeadd',
  props: {
    isEdit: {
      type: Boolean,
      default: false
    },
    info: {
      type: Object,
      default: null
    }
  },
  data() {
    return {
      form: {
        roomNumber: '',
        floor: '',
        typeId: ''
      },
      rules: {
        roomNumber: [
          { required: true, message: '请输入房间门牌号', trigger: 'blur' }
        ],
        typeId: [
          { required: true, message: '请选择房间类型', trigger: 'blur' }
        ],
        floor: [
          { required: true, message: '请输入所在楼层', trigger: 'blur' }
        ]
      },
      roomTypeList: [],
      loading: false,
      placeholder: '请输入所在楼层'
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
    selectRoomType(val) {
      // 获取房间类型的数据
      let currentType = this.roomTypeList.find(item => item.typeId==val);
      let placeholder = '请在' + currentType.floor + '中选择';
      // 修改/删除所在楼层的placeholder
      this.form.floor = '';
      this.placeholder = placeholder || '请输入所在楼层';
    },

    submit(func) {
      this.loading = true;
      this.$refs.ruleForm.validate((valid) => {
        if (valid) {
          let data = Object.assign(this.form);
          if (!this.isEdit) {
            addRoom(data).then(result => {
              if (result) {
                this.$message({
                  message: '添加成功',
                  type: 'success',
                  duration:1000
                });
                this.$refs.ruleForm.resetFields();
              }
            }).catch(res => {
              this.$message({
                message: res,
                type: 'error',
                duration:1000
              });
            }).finally(() => {
              this.loading = false;
            });
          } else {
            // 获取数据
            let data = Object.assign(this.form);
            data.roomId = this.info.roomId;
            // 请求
            editRoom(data).then(res => {
              func(res)
            });
          }
        } else {
          this.$message({
            message: '请完善表单',
            type: 'error',
            duration:1000
          });
          this.loading = false;
        }
      });
    },


    // 编辑模式，回显数据
    echoData() {
      this.form.roomNumber = this.info.roomNumber;
      this.form.typeId = this.info.typeId;
      this.form.floor = this.info.floor;
    }
  },
  created() {
    this.getRoomTypeList();
    if (this.isEdit) {
      this.echoData();
    }
  },
  watch: {
    info() {
      if (this.isEdit) {
        this.echoData();
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.form_div {
  padding: 40px;
  width: 40%;
}
</style>