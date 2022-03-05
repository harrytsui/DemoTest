<template>
  <div class="login-wrap">
    <el-form
      class="login-form"
      label-position="top"
      label-width="80px"
      :model="fromData"
    >
      <h2>注册</h2>
      <el-form-item label="用户名">
        <el-input
          v-model="fromData.username"
          placeholder="请输入用户名"
        ></el-input>
      </el-form-item>
      <el-form-item label="密码">
        <el-input
          v-model="fromData.password"
          placeholder="请输入密码"
          type="password"
        ></el-input>
      </el-form-item>
      <el-button class="btn-login" @click="handleregister" type="primary">
        注册
      </el-button>
    </el-form>
  </div>
</template>

<script>
import Web3 from "web3";
import contract from "truffle-contract";
import Ursc from '../../build/contracts/Ursc.json';
import { Message } from "element-ui";

export default {
  data() {
    return {
      fromData: {
        username: '',
        password: '',
      }
    };
  },

  async created() {
    // 初始化web3及账号
    await this.initWeb3Account()
    // 初始化合约实例
    await this.initContract()
  },

  methods: {
    async initWeb3Account() {
      if (window.ethereum) {
        this.provider = window.ethereum;
        try {
          await window.ethereum.enable();
        } catch (error) {
          //   console.log("User denied account access");
        }
      } else if (window.web3) {
        this.provider = window.web3.currentProvider;
      } else {
        this.provider = new Web3.providers.HttpProvider("http://127.0.0.1:8545");
      }
      this.web3 = new Web3(this.provider);
      this.web3.eth.getAccounts().then(accs  => {
        this.account = accs[0]
      });
    },

    async initContract() {
      const urscContract = contract(Ursc);
      urscContract.setProvider(this.provider);
      this.urscInstance = await urscContract.deployed();
    },

    checkEmpty() {
      return this.fromData.username !== '' && this.fromData.password !== '';
    },

    // 点击登录按钮
    async handleregister() {
        this.urscInstance.registerMember(this.fromData.username, this.fromData.password, {from: this.account,gas:210000}).on('receipt', function (receipt) 
          {console.log(receipt);
          Message({
          message: "注册成功",
          type: "success"
        });});
      //var self = this;
      //this.$store.state.contractInstance().methods.
      // this.urscInstance.registerMember(this.fromData.username, this.fromData.password).send({from: this.account,gas:300000}).on('receipt', function (receipt) {
      //        console.log(receipt);
      //           this.$message.success('注册成功');
      //          });
    }
  }

};
</script>

<style lang="less" scoped>
.login-wrap {
  height: 100%;
  background: #324152;
  display: flex;
  justify-content: center;
  align-items: center;

  .login-form {
    background: #fff;
    width: 560px;
    height: 400px;
    padding: 30px;
    border-radius: 12px;

    .btn-login {
      width: 100%;
    }
  }
}
</style>
