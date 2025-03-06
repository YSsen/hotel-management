'use strict'
const path = require('path')

function resolve(dir) {
  return path.join(__dirname, dir)
}


module.exports = {
  configureWebpack: {
    devtool: 'source-map',
  },
  devServer: {
    port: 8080, // 设置端口
    open: false // 自动打开浏览器
  },
  runtimeCompiler: true,

  chainWebpack(config) {
    config.plugins.delete("preload"); // TODO: need test
    config.plugins.delete("prefetch"); // TODO: need test

    // set svg-sprite-loader
    config.module
      .rule("svg")
      .exclude.add(resolve("src/icons"))
      // .add(resolve("src/assets/icons"))//如果还有其他文件夹下有，就add增加
      .end();
    config.module
      .rule("icons")
      .test(/\.svg$/)
      .include.add(resolve("src/icons"))
      // .add(resolve("src/assets/icons"))
      .end()
      .use("svg-sprite-loader")
      .loader("svg-sprite-loader")
      .options({ symbolId: "icon-[name]" })
      .end();

  },

}