import request from '@/utils/request'
import Qs from 'qs'

// 开房、入住
export function checkIn(data) {
  return request({
    url: '/op/order/check-in',
    method: 'post',
    data: Qs.stringify(data)
  })
}

// 预定
export function reserve(data) {
  return request({
    url: '/op/order/add',
    method: 'post',
    data: Qs.stringify(data)
  })
}
// 官网预定，后台要随机选择一个房间
export function reserve2(data) {
  return request({
    url: '/op/order/add2',
    method: 'post',
    data: Qs.stringify(data)
  })
}

// 获取预定订单信息
export function getReservation(roomId) {
  return request({
    url: '/op/order/reserve-info/'+roomId,
    method: 'get'
  })
}

// 换房
export function changeRoom(data) {
  return request({
    url: '/op/order/change',
    method: 'post',
    data: Qs.stringify(data)
  })
}

// 退房
export function checkOut(roomId) {
  return request({
    url: '/op/order/check-out/'+roomId,
    method: 'get'
  })
}

// 退房（取消预定）
export function cancelReserve(roomId) {
  return request({
    url: '/op/order/cancel/'+roomId,
    method: 'get'
  })
}

export function deleteOrder(id) {
  return request({
    url: '/op/order/delete/'+id,
    method: 'get'
  })
}
