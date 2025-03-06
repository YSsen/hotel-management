<template>
  <div>
    <!--  ,  , ,  -->
    <el-form class="form_div" :rules="rules" ref="ruleForm" :model="form" label-width="120px">
      <el-form-item label="房型名称" prop="typeName">
        <el-input
          v-model="form.typeName" placeholder="请输入房型名称"
        ></el-input>
      </el-form-item>
      <el-form-item label="房间数量" prop="typeNum">
        <el-input type="number" v-model="form.typeNum" placeholder="请输入房间数量"
        ></el-input>
      </el-form-item>
      <el-form-item label="房间价格" prop="price">
        <el-input v-model="form.price" placeholder="请输入房间价格"></el-input>
      </el-form-item>
      <el-form-item label="需交押金" prop="deposit">
        <el-input v-model="form.deposit" placeholder="请输入需交押金"></el-input>
      </el-form-item>
      <el-form-item label="客房床型" prop="typeBed">
        <el-input v-model="form.typeBed" placeholder="请输入客房床型"></el-input>
      </el-form-item>
      <el-form-item label="房间面积" prop="area">
        <el-input v-model="form.area" placeholder="请输入房间面积">
          <template slot="append">m<sup>2</sup></template>
        </el-input>
      </el-form-item>
      <el-form-item label="可住人数" prop="tcNum">
        <el-input v-model="form.tcNum" placeholder="请输入可住人数"></el-input>
      </el-form-item>
      <el-form-item label="所在楼层" prop="floor">
        <el-input v-model="form.floor" placeholder="请输入所在楼层"></el-input>
      </el-form-item>
      <el-form-item label="房型图片" prop="picture">
        <!-- 
          :on-preview="handlePreview"
          :on-remove="handleRemove"
          :before-remove="beforeRemove"
          :on-exceed="handleExceed"
           -->
        <el-upload
          class="avatar-uploader"
          :show-file-list="false"
          :action="baseUrl + '/upload/file'"
          :file-list="fileList"
          :on-success="handleAvatarSuccess"
          :before-upload="beforeAvatarUpload"
        >
          <img v-if="form.picture" :src="url + form.picture" class="avatar">
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          <!-- <el-button size="small" type="primary">点击上传</el-button> -->
          <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过2MB</div>
        </el-upload>
      </el-form-item>
    </el-form>
    <div class="footer" v-show="!isEdit">
      <el-button type="primary" :loading="loading" @click="submit">确 定 提 交</el-button>
    </div>
  </div>
</template>

<script>
import { MessageBox } from 'element-ui'
import {addRoomType, editRoomType} from '@/api/roomType'
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
        typeName: '',
        typeNum: '',
        price: '',
        deposit: '',
        typeBed: '',
        area: '',
        tcNum: '',
        floor: '',
        // isDish: '',
        picture: ''
      },
      rules: {
        typeName: [
          { required: true, message: '请输入房型名称', trigger: 'blur' }
        ],
        typeNum: [
          { required: true, message: '请输入房间数量', trigger: 'blur' }
        ],
        price: [
          { required: true, message: '请输入房间价格', trigger: 'blur' }
        ],
        deposit: [
          { required: true, message: '请输入需交押金', trigger: 'blur' }
        ],
        typeBed: [
          { required: true, message: '请输入客房床型', trigger: 'blur' }
        ],
        area: [
          { required: true, message: '请输入房间面积', trigger: 'blur' }
        ],
        tcNum: [
          { required: true, message: '请输入可住人数', trigger: 'blur' }
        ],
        floor: [
          { required: true, message: '请输入所在楼层', trigger: 'blur' }
        ],
        // isDish: [
        //   { required: true, message: '请选择是否含早餐', trigger: 'blur' }
        // ],
        picture: [
          { required: true, message: '请选择图片', trigger: 'change' }
        ]
      },
      url: process.env.VUE_APP_BASE_URL+'/upload/echo/',
      imageUrl: '', //存储图片地址
      baseUrl: process.env.VUE_APP_BASE_URL,
      fileList: [],
      loading: false
    }
  },
  methods: {
    //图片回显
    handleAvatarSuccess(res) {
      
      // 401:未登录;
      if (res.code === 1100) {
        MessageBox.confirm('你已被登出，可以取消继续留在该页面，或者重新登录', '确定登出', {
          confirmButtonText: '重新登录',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$router.push({path: '/login'})
        })
      }

      console.log(res);
      this.form.picture = res.data;
      this.$refs.ruleForm.clearValidate('picture')
    },
    beforeAvatarUpload(file) {
      // 在上传之前的处理逻辑，例如文件大小限制、文件类型限制等
      const isJPG = file.type === 'image/jpeg';
      const isPNG = file.type === 'image/png';
      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!(isJPG || isPNG)) {
        this.$message.error('上传头像图片只能是 JPG 或 PNG 格式!');
      }

      if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 2MB!');
      }

      return (isJPG || isPNG) && isLt2M;
    },

    submit(func) {
      this.loading = true;
      this.$refs.ruleForm.validate((valid) => {
        if (valid) {
          let data = Object.assign(this.form);
          if (!this.isEdit) {
            addRoomType(data).then(result => {
              if (result) {
                this.$message({
                  message: '添加成功',
                  type: 'success',
                  duration:1000
                });
                this.$refs.ruleForm.resetFields();
                this.fileList = [];
              }else {
                this.$message({
                  message: '添加失败',
                  type: 'error',
                  duration:1000
                });
              }
            }).finally(() => {
              this.loading = false;
            });
          } else {
            // 获取数据
            let data = Object.assign(this.form);
            data.typeId = this.info.typeId;
            // 请求
            editRoomType(data).then(res => {
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
      this.form.typeName = this.info.typeName;
      this.form.typeNum = this.info.typeNum;
      this.form.price = this.info.price;
      this.form.deposit = this.info.deposit;
      this.form.typeBed = this.info.typeBed;
      this.form.area = this.info.area;
      this.form.tcNum = this.info.tcNum;
      this.form.floor = this.info.floor;
      this.form.picture = this.info.picture;

      this.fileList = [{
        name: this.form.picture,
        url: ''
      }]
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
.form_div {
  .avatar-uploader .el-upload {
      border: 1px dashed #d9d9d9;
      border-radius: 6px;
      cursor: pointer;
      position: relative;
      overflow: hidden;
      img {
        object-fit: contain;
      }
    }
    .avatar-uploader .el-upload:hover {
      border-color: #409EFF;
    }
    .avatar-uploader-icon {
      font-size: 28px;
      color: #8c939d;
      width: 178px;
      height: 178px;
      line-height: 178px;
      text-align: center;
    }
    .avatar {
      width: 178px;
      height: 178px;
      display: block;
    }
}
</style>