
import Vue from "vue";
import Router from "vue-router";

import homepage from "@/views/website/HomePage.vue";
import Reservation from "@/views/website/Reservation.vue";

import Layout from '@/views/management/layout/Layout';

// 启用路由
Vue.use(Router);
// 导出路由
const routes = [
  {
    path: "/",
    name: "default",
    redirect: '/homepage',
  },
  {
    path: "/homepage",
    name: "homepage",
    component: homepage
  },
  {
    path: "/reservation",
    name: "Reservation",
    component: Reservation
  },

  {path: '/login', component: () => import('@/views/management/login/index'), hidden: true},
  {path: '/404', component: () => import('@/views/404'), hidden: true},
  {
    path: "/home",
    redirect: "/check/checkin"
  },
  {
    path: "/check",
    component: Layout,
    name: 'oper',
    meta: {title: '客房操作', icon: 'room'},
    children: [
      {
        path: 'checkin',
        name: 'check',
        component: () => import('@/views/management/home/CheckIn'),
        meta: {title: '开房订房' }
      },
      // {
      //   path: 'searchinfo',
      //   name: 'search',
      //   component: () => import('@/views/management/home/RoomSearch'),
      //   meta: {title: '信息查询' }
      // },
      {
        path: 'cost',
        name: 'cost',
        component: () => import('@/views/management/order/CostList'),
        meta: {title: '订单管理' }
      },
    ]
  },
  {
    path: "/roomtype",
    component: Layout,
    name: 'oper2',
    meta: {title: '房型操作', icon: 'roomtype'},
    children: [
      {
        path: 'addinfo',
        name: 'addroomtype',
        component: () => import('@/views/management/home/TypeAdd'),
        meta: {title: '新增房型' }
      },
      {
        path: 'searchinfo',
        name: 'alterroomtype',
        component: () => import('@/views/management/home/TypeList'),
        meta: {title: '房型管理' }
      },
    ]
  },
  {
    path: "/room",
    component: Layout,
    name: 'oper22',
    meta: {title: '房间管理', icon: 'room'},
    children: [
      {
        path: 'addroom',
        name: 'addroom',
        component: () => import('@/views/management/home/RoomAdd'),
        meta: {title: '新增房间' }
      },
      {
        path: 'roomlist',
        name: 'alterroom',
        component: () => import('@/views/management/home/RoomList'),
        meta: {title: '房间管理' }
      },
    ]
  },
  // {
  //   path: "/order",
  //   component: Layout,
  //   name: 'oper3',
  //   meta: {title: '订单管理', icon: 'order'},
  //   children: [
  //     // {
  //     //   path: 'changeing',
  //     //   name: 'changeroom',
  //     //   component: () => import('@/views/management/order/ChangeingList'),
  //     //   meta: {title: '换房记录' }
  //     // },
  //     {
  //       path: 'cost',
  //       name: 'cost',
  //       component: () => import('@/views/management/order/CostList'),
  //       meta: {title: '消费记录' }
  //     },
  //   ]
  // },
  {
    path: "/user",
    component: Layout,
    name: 'oper4',
    meta: {title: '用户管理', icon: 'user'},
    children: [
      {
        path: 'adduser',
        name: 'adduser',
        component: () => import('@/views/management/user/UserAdd'),
        meta: {title: '添加用户' }
      },
      {
        path: 'userlist',
        name: 'userlist',
        component: () => import('@/views/management/user/UserList'),
        meta: {title: '用户管理' }
      },
      // {
      //   path: 'pwd',
      //   name: 'pwd',
      //   component: () => import('@/views/management/user/PwdChange'),
      //   meta: {title: '修改密码' }
      // },
    ]
  }
]

const router = new Router({
  routes,
})
export default router;
