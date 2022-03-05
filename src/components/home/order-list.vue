<template>
  <div>
    <el-table :data="tableData" max-height="840px">
      <el-table-column label="序号" prop="num"> </el-table-column>

      <el-table-column label="任务名称" prop="taskname"> </el-table-column>

      <el-table-column label="任务ID" prop="id"> </el-table-column>

      <el-table-column label="任务描述" prop="taskdescription"></el-table-column>

      <el-table-column label="状态" prop="status"> </el-table-column>

      <el-table-column label="所属角色" prop="role"> </el-table-column>

      <el-table-column label="创建时间" prop="createtime"> </el-table-column>

      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="danger"
            @click="publishTask(scope.$index, scope.row)"
          >
            查看
          </el-button>
          <el-button
            size="mini"
            type="danger"
            @click="publishTask(scope.$index, scope.row)"
          >
            完成
          </el-button>
          <el-button
            size="mini"
            type="danger"
            @click="publishTask(scope.$index, scope.row)"
          >
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-pagination
      class="pagination"
      background
      layout="prev, pager, next"
      :total="50"
      :page-size="12"
    >
    </el-pagination>
  </div>
</template>

<script>
import Web3 from "web3";
import contract from "truffle-contract";
import Tpsc from '../../../build/contracts/Tpsc.json';
import { Message } from "element-ui";

export default {
  data() {
    return {
      tableData: [{
        num: '1',
        taskname: '噪音数据采集',
        id: '000002',
        taskdescription: '采集城郊噪音数据',
        status: '进行中',
        role: '任务发起者',
        createtime: '2021/12/18'
      }, {
        id: 'EH115565478657',
        taskname: '一曲',
        total_amount: '58.00',
        payment_amount: '58.00',
        date: '2021/12/18',
        status: '交易成功'
      }, {
        id: 'EH115565478657',
        taskname: '一曲',
        total_amount: '58.00',
        payment_amount: '58.00',
        date: '2021/4/18 16:22:01',
        status: '交易成功'
      }, {
        id: 'EH115565478657',
        taskname: '一曲',
        total_amount: '58.00',
        payment_amount: '58.00',
        date: '2021/4/18 16:22:01',
        status: '交易成功'
      }, {
        id: 'EH115565478657',
        taskname: '一曲',
        total_amount: '58.00',
        payment_amount: '58.00',
        date: '2021/4/18 16:22:01',
        status: '交易成功'
      }, {
        id: 'EH115565478657',
        taskname: '一曲',
        total_amount: '58.00',
        payment_amount: '58.00',
        date: '2021/4/18 16:22:01',
        status: '交易成功'
      },],
    }
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
      const tpscContract = contract(Tpsc);
      tpscContract.setProvider(this.provider);
      this.tpscInstance = await tpscContract.deployed();
    },

    // 发布新任务
    async publishTask(index, row) {
      this.tpscInstance.addTask('1', '2', '2','2', {from: this.account,gas:210000}).on('receipt', function (receipt) 
          {console.log(receipt);
          Message({
          message: "发布成功",
          type: "success"
        });});

      this.$alert(`删除 “${row.id}” ？`, '确认删除', {
        confirmButtonText: '确定',
        callback: action => {
          if (action === 'cancel') {
            this.$message.info('操作取消');
          }
        }
      });
    }
  },
}
</script>

<style lang="less" scoped>
.pagination {
  margin-top: 10px;
  margin-bottom: 12px;
}
</style>