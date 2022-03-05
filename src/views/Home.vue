<template>
  <el-container class="container">
    <!-- header -->
    <el-header class="header">
      <el-row >
        <el-col :span="4"> CSChain </el-col>
        <el-col class="logout-div" :span="4" :offset="16">
          <a class="logout" @click="handleLogout">退出</a>
        </el-col>
      </el-row>
    </el-header>
    <!-- container -->
    <el-container>
      <!-- Menu -->
      <el-aside class="aside" width="230px">
        <el-menu
          default-active="user-list"
          class="el-menu-vertical-demo"
          @select="select"
        >
          <!-- 任务管理 -->
          <el-submenu index="1">
            <template slot="title">
              <i class="el-icon-menu"></i>
              <span>任务管理</span>
            </template>
            <el-menu-item-group>
              <!--template slot="title">管理你的用户</template-->
              <el-menu-item index="order-list">
                <span>发布任务</span>
              </el-menu-item>
              <el-menu-item index="order-list">
                <span>我的任务</span>
              </el-menu-item>
              <el-menu-item index="order-list">
                <span>任务广场</span>
              </el-menu-item>
            </el-menu-item-group>
          </el-submenu>

          <!-- 发布任务 -->
          <el-submenu index="2">
            <template slot="title">
              <i class="el-icon-menu"></i>
              <span>发布任务</span>
            </template>
            <el-menu-item-group>
              <template slot="title">管理你的商品</template>
              <el-menu-item index="goods-list">商品列表</el-menu-item>
            </el-menu-item-group>
          </el-submenu>

          <!-- 订单管理 -->
          <el-submenu index="3">
            <template slot="title">
              <i class="el-icon-menu"></i>
              <span>我的任务</span>
            </template>
            <el-menu-item-group>
              <template slot="title">管理你的订单</template>
              <el-menu-item index="order-list">订单列表</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
        </el-menu>
      </el-aside>

      <!-- 订单管理 -->
          <el-submenu index="4">
            <template slot="title">
              <i class="el-icon-menu"></i>
              <span>我的任务</span>
            </template>
            <el-menu-item-group>
              <template slot="title">管理你的订单</template>
              <el-menu-item index="order-list">订单列表</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
        </el-menu>
      </el-aside>

      <!-- Main -->
      <el-main class="main">
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
export default {


  beforeMount() {
    this.$message.success('欢迎回来');
  },

  methods: {

    // 切换菜单
    select(index) {
      let path = '/home/' + index;
      if (this.$route.path === path)
        return
      this.$router.push(path);
    },

    // 点击退出
    handleLogout() {
      this.$router.push('/login');
      this.$message.info('已退出');
    }
  },



}
</script>

<style lang="less">
.container {
  height: 100%;
  .header {
    line-height: 60px;
    background-color: #b3c0d1;
    .title-div {
      text-align: center;
    }
    .logout-div {
      text-align: right;
      a {
        cursor: pointer;
      }
    }
  }
  .aside {
    background-color: #d3dce6;
  }
  .main {
    background-color: #e9eef3;
  }
}
</style>