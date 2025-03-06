<template>
  <div>
    <el-form class="form_div" :rules="rules" ref="ruleForm" :model="form" label-width="120px">
      <el-form-item label="用户昵称" prop="name">
        <el-input
          v-model="form.name" placeholder="请输入用户昵称"
        ></el-input>
      </el-form-item>
      <el-form-item label="联系电话" prop="phone">
        <el-input v-model="form.phone" placeholder="请输入联系电话"></el-input>
      </el-form-item>
      <el-form-item label="登录账号" prop="username">
        <el-input v-model="form.username" placeholder="请输入用户登录账号"
        ></el-input>
      </el-form-item>
      <el-form-item label="密码" prop="password" v-show="!isEdit">
        <el-input v-model="form.password" placeholder="请输入密码"></el-input>
      </el-form-item>
      <el-form-item label="所属角色" prop="role" class="thi">
        <el-radio-group v-model="form.role" size="small">
          <el-radio-button label="admin">管理员</el-radio-button>
          <el-radio-button label="operator">工作人员</el-radio-button>
        </el-radio-group>
      </el-form-item>
    </el-form>
    <div class="footer" v-show="!isEdit">
      <el-button type="primary" :loading="loading" @click="submit">确 定 提 交</el-button>
    </div>
  </div>
</template>

<script>
import {addUser, editUser} from '@/api/user'
export default {
  name: 'userAdd',
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
      loading: false,
      form: {
        name: '',
        username: '',
        password: '',
        phone: '',
        role: 'operator'
      },
      rules: {
        name: [
          { required: true, message: '请输入用户昵称', trigger: 'blur' }
        ],
        phone: [
          { required: true, message: '请输入联系电话', trigger: 'blur' }
        ],
        username: [
          { required: true, message: '请输入用户登录账号', trigger: 'blur' }
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' }
        ],
        role: [
          { required: true, message: '请选择所属角色', trigger: 'blur' }
        ],
      }
    }
  },
  methods: {
    submit(func) {
      this.loading = true;
      this.$refs.ruleForm.validate((valid) => {
        if (valid) {
          let data = Object.assign(this.form);
          if (!this.isEdit) {
            addUser(data).then(result => {
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
            data.workerId = this.info.workerId;
            delete data.password;
            // 请求
            editUser(data).then(res => {
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
      this.form.name = this.info.name;
      this.form.username = this.info.username;
      this.form.password = this.info.password;
      this.form.phone = this.info.phone;
      this.form.role = this.info.role;
    }
  },
  created() {
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
<style lang="scss">
.thi {
  .el-form-item__content {
    text-align: left;
  }
}
</style>