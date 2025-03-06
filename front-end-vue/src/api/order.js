import request from '@/utils/request'
import Qs from 'qs'

export function getOrderList(data) {
  return request({
    url: '/op/order/list',
    method: 'post',
    data: Qs.stringify(data)
  })
}

export function deleteOrder(id) {
  return request({
    url: '/op/order/delete/'+id,
    method: 'get'
  })
}

export function getOrderInfo(phone) {
  return request({
    url: '/op/order/info/'+phone,
    method: 'get'
  })
}
