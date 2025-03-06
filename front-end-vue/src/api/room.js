import request from '@/utils/request'
import Qs from 'qs'

export function addRoom(data) {
  return request({
    url: '/op/room/add',
    method: 'post',
    data: data
  })
}

export function getRoomList(data) {
  return request({
    url: '/op/room/list',
    method: 'post',
    data: Qs.stringify(data)
  })
}

export function getRoomList2(data) {
  return request({
    url: '/op/room/list2',
    method: 'post',
    data: Qs.stringify(data)
  })
}

export function editRoom(data) {
  return request({
    url: '/op/room/update',
    method: 'post',
    data: data
  })
}

export function deleteRoom(id) {
  return request({
    url: '/op/room/delete/'+id,
    method: 'get'
  })
}

export function getInfo() {
  return request({
    url: '/admin/info',
    method: 'get',
  })
}
