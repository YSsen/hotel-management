<template>
  <div>
    <!-- logo -->
    <div class="logo">
      <img src="@/assets/logo.png" alt=""><span>伦兰唯尚酒店</span>
    </div>
    <!-- 酒店图片 -->
    <div class="hotel_img">
      <img id="hotel" src="@/assets/hotel2.jpg" alt="">
    </div>
    <!-- 酒店说明 -->
    <div class="hotel_info">
      <div class="top">身处历史悠久的迷人外滩，感受重新演绎的上海风范</div>
    </div>
    <!-- 客房及套房 -->
    <div class="room_img">
      <div class="row1">
        <div>客房及套房</div>
        <div class="btn"><el-button type="text" @click="goReserve">查看更多</el-button></div>
      </div>
      <el-carousel :autoplay="false" type="card" height="340px" trigger="click" indicator-position="none">
        <el-carousel-item v-for="(item, index) in tableData" :key="index">
          <div class="item">
            <img :src="url+item.picture" alt="">
            <span>{{item.typeName}}</span>
          </div>
        </el-carousel-item>
      </el-carousel>
    </div>
    <!-- 酒店设施及服务说明 -->
    <div class="serve_des">
      <h4 class="title">酒店设施及服务</h4>
      <!-- grid布局 -->
      <div class="des">
        <div class="item">
          <i class="el-icon-knife-fork"></i>
          <span>餐厅</span>
        </div>
        <div class="item">
          <img src="@/assets/train.png" alt="">
          <span>健身中心</span>
        </div>
        <div class="item">
          <img src="@/assets/swim.png" alt="">
          <span>室内游泳</span>
        </div>
        <div class="item">
          <i class="el-icon-hot-water"></i>
          <span>热水池</span>
        </div>
        <div class="item">
          <i class="el-icon-date"></i>
          <span>会议空间</span>
        </div>
        <div class="item">
          <img src="@/assets/wifi.png" alt="">
          <span>免费Wi-Fi</span>
        </div>
        <div class="item">
          <img src="@/assets/flush.png" style="width: 24px;" alt="">
          <span>干洗服务</span>
        </div>
        <div class="item">
          <i class="el-icon-refrigerator"></i>
          <span>厨房</span>
        </div>
      </div>
    </div>
    <!-- 酒店信息说明 -->
    <div class="hotel_des">
      <h4 class="title">酒店信息</h4>
      <!-- flex布局 -->
      <div class="des">
        <div class="sub1">
          <div class="item">
            <i class="el-icon-time"></i>
            <span>登记入住:</span>
            <label>下午2:00</label>
          </div>
          <div class="item">
            <i class="el-icon-time"></i>
            <span>退房:</span>
            <label>上午12:00</label>
          </div>
          <div class="item">
            <i class="el-icon-circle-close"></i>
            <span>无烟酒店</span>
          </div>
        </div>
        <div class="sub2">
          <div class="row1">
            <img class="icon_img" src="@/assets/pet.png">
            <span>宠物政策</span>
          </div>
          <div class="row2">
            <label>不允许携带宠物</label>
            <div></div>
            <label>No pets allowed</label>
          </div>
        </div>
        <div class="sub3">
          <div class="row1">
            <img class="icon_img" src="@/assets/park.png">
            <span>停车</span>
          </div>
          <div class="row2">
            <label>酒店内停车</label><div></div>
            <label>每小时: ¥6</label><div style="margin-bottom: 10px;"></div>
            <label>额外停车信息</label><div></div>
            <label>温馨提示：酒店住客可免费停车。</label>
          </div>
        </div>
      </div>
    </div>
    <!-- 实况展示 -->
    <!-- flex -->
    <div class="share">
      <div class="item">
        <img src="@/assets/11.png" alt="">
        <div class="title">让住宿体验创造更多可能</div>
        <div class="horizon"></div>
        <div class="des">在酒店大堂吧深入了解鸡尾酒的历史与知识，或与曼联球员共探新知，您的酒店体验从不止步于一间居所。</div>
      </div>
      <div class="item">
        <img src="@/assets/12.png" alt="">
        <div class="title">精彩旅程，美味相伴</div>
        <div class="horizon"></div>
        <div class="des">欢迎前来酒店餐厅享受优雅环境和可口菜品，亦可选购外带小吃，随时乐享美味。您可享用各式简餐，也可品味融合了当地特色的经典菜肴，在熟悉的餐点中体验意想不到的美妙风味。</div>
      </div>
      <div class="item">
        <img src="@/assets/13.png" alt="">
        <div class="title">居家呵护，便捷常在</div>
        <div class="horizon"></div>
        <div class="des">选购我们标志性的枕头和卫浴护肤系列等居家好物，让我们的精心设计助您打造舒适惬意的居家空间。</div>
      </div>
    </div>

    <!-- 留白 -->
    <div style="height: 100px;background-color:#f1e8e8;"></div>
  </div>
</template>

<script>
import {getAllRoomTypeList} from '@/api/roomType'

export default {
  name: 'homepage',
  data() {
    return {
      tableData: [],
      url: process.env.VUE_APP_BASE_URL+'/upload/echo/'
    }
  },
  methods: {
    getDataList() {
      getAllRoomTypeList().then(res => {
        this.tableData = res.data;
      }).catch(() => {
        this.$message({
          message: '查询列表失败',
          type: 'error',
          duration:1000
        });
      });
    },
    goReserve() {
      this.$router.push('/reservation')
    }
  },
  created() {
    this.getDataList();
    // 
    window.onscroll = function() {
      let image = document.getElementById('hotel');
      let scrolled = window.pageYOffset || document.documentElement.scrollTop;

      // let scale = 1;
      // scale += scrolled * 0.0005; // 根据滚轮的滚动方向放大或缩小

      image.style.objectPosition = '0 ' + (scrolled * (0.5)) + 'px';
      // image.style.transform = 'scale(' + scale + ')';
    };
  }
}
</script>

<style lang="scss" scoped>
.logo {
  text-align: left;
  display: flex;
  align-items: center;
  background: #f1e8e8;
  padding: 10px 0;
  position: sticky;
  top:0;
  z-index: 99;
  img {
    width: 80px;
  }
  span {
    margin-left: 20px;
    font-size: 30px;
    color: #d6876e;
    letter-spacing: 4px;
  }
}
.hotel_img {
  width: 100%;
  height: 800px;
  margin: auto;
  overflow: hidden;
  img {
    height: 100%;
    width: 100%;
    object-fit: cover;
    object-position: top;
    transform-origin: center center; /* 设置变换的原点 */
    transition: transform 0.3s ease-out; /* 平滑过渡效果 */
  }
}
.hotel_info {
  font-size: 40px;
  margin: 20px;
  letter-spacing: 2px;
  font-family: fantasy;
}
.room_img {
  width: 1200px;
  height: 450px;
  margin: auto;
  padding: 40px 0;
  .row1 {
    text-align: left;
    font-size: 32px;
    padding: 40px 0;
    display: flex;
    justify-content: space-between;
  }
  .item {
    display: flex;
    flex-direction: column;
    overflow: hidden;
    img {
      height: 300px;
      width: 100%;
      object-fit: cover;
    }
    span {
      font-size: 24px;
      text-align: center;
    }
  }
}
.serve_des {
  width: 1200px;
  margin: auto;
  padding: 40px 0;
  .title {
    font-size: 24px;
    text-align: left;
  }
  .des {
    display: grid;
    grid-template-columns: repeat(3, 33%);
    grid-template-rows: repeat(3, 60px);
    .item {
      font-size: 18px;
      font-weight: bold;
      text-align: left;
      display: flex;
      align-items: center;
      i {
        font-size: 22px;
        font-weight: bold;
      }
      img {
        width: 22px;
      }
      span {
        margin: 2px 4px;
      }
    }
  }
}
.hotel_des {
  width: 1200px;
  margin: auto;
  padding: 40px 0;
  .title {
    font-size: 24px;
    text-align: left;
  }
  .des {
    display: grid;
    grid-template-columns: repeat(3, 33%);
    .sub1, .sub2, .sub3 {
      font-size: 18px;
      font-weight: bold;
      text-align: left;
      display: flex;
      flex-direction: column;
      align-items: flex-start;
      i {
        font-size: 22px;
        font-weight: bold;
      }
      img {
        width: 22px;
      }
      span {
        margin: 2px 4px;
      }
      label {
        margin-left: 10px;
        font-weight: normal;
      }
    }
    .sub1 .item {
      margin-bottom: 30px;
      display: flex;
      align-items: center;
    }
    .sub2, .sub3 {
      .row1 {
        display: flex;
        align-items: center;
        img {
          width: 26px;
        }
      }
      .row2 {
        padding-top: 10px;
      }
    }
  }
}
.share {
  width: 1200px;
  margin: auto;
  padding: 40px 0;
  display: grid;
  grid-template-columns: repeat(3, 33%);
  .item {
    .title {
      font-size: 32px;
      text-align: left;
      margin-top: 20px;
      padding-left: 20px;
    }
    .horizon {
      width: 30%;
      height: 6px;
      background: #a70023;
      margin: 20px;
    }
    .des {
      padding: 0 20px;
      font-size: 20px;
      text-align: left;
    }
  }
}
</style>