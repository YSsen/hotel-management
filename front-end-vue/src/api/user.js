import request from '@/utils/request'
import Qs from 'qs'

export function addUser(data) {
  return request({
    url: '/admin/operator/add',
    method: 'post',
    data: data
  })
}

export function getUserList(data) {
  return request({
    url: '/admin/operator/list',
    method: 'post',
    data: Qs.stringify(data)
  })
}

export function editUser(data) {
  return request({
    url: '/admin/operator/update',
    method: 'post',
    data: data
  })
}

export function deleteUser(id) {
  return request({
    url: '/admin/operator/delete/'+id,
    method: 'get'
  })
}

export function getUserInfo() {
  return request({
    url: '/admin/operator/info',
    method: 'get',
  })
}

export function changePwd(data) {
  return request({
    url: '/admin/operator/updatePassword',
    method: 'post',
    data: Qs.stringify(data)
  })
}