import request from '@/utils/request'
import Qs from 'qs'

export function login(username, password) {
  return request({
    url: '/login/admin',
    method: 'post',
    data: Qs.stringify({
      username,
      password
    })
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
