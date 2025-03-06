<template>
  <div>
    <el-menu class="navbar" mode="horizontal">
      <hamburger class="hamburger-container" :toggleClick="toggleSideBar" :isActive="sidebar.opened"></hamburger>
      <breadcrumb></breadcrumb>
      <el-dropdown class="avatar-container" trigger="click">
        <div class="avatar-wrapper">
          <!-- <img class="user-avatar" :src="avatar">
          <i class="el-icon-caret-bottom"></i> -->
          你好，{{name}}
        </div>
        <el-dropdown-menu class="user-dropdown" slot="dropdown">
          <!-- <router-link class="inlineBlock" to="/">
            <el-dropdown-item>
              首页
            </el-dropdown-item>
          </router-link> -->
          <el-dropdown-item divided>
            <span @click="alterPwd" style="display:block;">修改密码</span>
          </el-dropdown-item>
          <el-dropdown-item divided>
            <span @click="logout" style="display:block;">退出</span>
          </el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </el-menu>

    <!-- 修改密码 -->
    <el-dialog
      title="修改密码"
      class="dialog_div"
      :visible.sync="dialogVisible"
      width="40%"
    >
      <div slot="title" class="title">修改密码</div>

      <PwdChange :userInfo="userInfo" ref="editForm"></PwdChange>

      <div slot="footer" class="dialog-footer">
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Breadcrumb from './Breadcrumb'
import Hamburger from './Hamburger'
import { Message } from 'element-ui'
import PwdChange from './PwdChange'

export default {
  components: {
    Breadcrumb,
    Hamburger,
    PwdChange
  },
  computed: {
    ...mapGetters([
      'sidebar',
      'avatar'
    ])
  },
  data() {
    return {
      name: '管理员',
      dialogVisible: false,
      userInfo: null
    }
  },
  methods: {
    toggleSideBar() {
      this.$store.dispatch('ToggleSideBar')
    },
    logout() {
      this.$store.dispatch('LogOut').then(() => {
        // location.reload() // 为了重新实例化vue-router对象 避免bug
        Message({
          message: '已退出',
          type: 'success',
          duration: 3 * 1000
        })
        this.$router.push({path: '/login'})
      })
    },
    alterPwd() {
      this.dialogVisible = true;
    }
  },
  created() {
    this.userInfo = JSON.parse(sessionStorage.getItem("user"));
    this.name = this.userInfo.name;
  }
}
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
.navbar {
  height: 50px;
  line-height: 50px;
  border-radius: 0px !important;
  .hamburger-container {
    line-height: 58px;
    height: 50px;
    float: left;
    padding: 0 10px;
  }
  .screenfull {
    position: absolute;
    right: 90px;
    top: 16px;
    color: red;
  }
  .avatar-container {
    height: 50px;
    display: inline-block;
    position: absolute;
    right: 35px;
    .avatar-wrapper {
      cursor: pointer;
      margin-top: 5px;
      position: relative;
      .user-avatar {
        width: 40px;
        height: 40px;
        border-radius: 10px;
      }
      .el-icon-caret-bottom {
        position: absolute;
        right: -20px;
        top: 25px;
        font-size: 12px;
      }
    }
  }
}
</style>

