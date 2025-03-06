import request from '@/utils/request'

export function addRoomType(data) {
  return request({
    url: '/op/room-type/add',
    method: 'post',
    data: data
  })
}

export function getAllRoomTypeList(data) {
  return request({
    url: '/op/room-type/all',
    method: 'post',
    data: data
  })
}

export function editRoomType(data) {
  return request({
    url: '/op/room-type/update',
    method: 'post',
    data: data
  })
}

export function deleteRoomType(id) {
  return request({
    url: '/op/room-type/delete/'+id,
    method: 'get'
  })
}

export function getInfo() {
  return request({
    url: '/admin/info',
    method: 'get',
  })
}

export function logout() {
  return request({
    url: '/login/out',
    method: 'post'
  })
}
