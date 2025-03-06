<template>
  <div>
    <el-form class="form_div" :rules="rules" ref="ruleForm" :model="form" label-width="120px">
      <el-form-item label="新密码" prop="newPwd">
        <el-input v-model="form.newPwd" placeholder="请输入密码"></el-input>
      </el-form-item>
      <el-form-item label="确认密码" prop="pwd">
        <el-input v-model="form.pwd" placeholder="请输入密码"></el-input>
      </el-form-item>
    </el-form>
    <div class="footer">
      <el-button type="primary" :loading="loading" @click="submit">确 定 提 交</el-button>
    </div>
  </div>
</template>

<script>
import {changePwd} from '@/api/user'

export default {
  name: 'pwdChange',
  props: {
    userInfo: {
      type: Object,
      default: null
    }
  },
  data() {
    return {
      loading: false,
      form: {
        newPwd: '',
        pwd: ''
      },
      rules: {
        newPwd: [
          { required: true, message: '请输入密码', trigger: 'blur' }
        ],
        pwd: [
          { required: true, message: '请输入密码', trigger: 'blur' }
        ]
      }
    }
  },
  methods: {
    submit() {
      this.$refs.ruleForm.validate((valid) => {
        if (valid) {
          if (this.form.newPwd != this.form.pwd) {
            this.$message({
              message: '两次密码输入不一致！',
              type: 'error',
              duration:2000
            });
          } else {
            let data = {
              workerId: this.userInfo.workerId,
              newPassword: this.form.newPwd
            }
            changePwd(data).then(result => {
              if (result) {
                this.$message({
                  message: '修改成功',
                  type: 'success',
                  duration:1000
                });
                this.$store.dispatch('LogOut').then(() => {
                  this.$router.push({path: '/login'})
                });
              }
            })
          }
        }
      })
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