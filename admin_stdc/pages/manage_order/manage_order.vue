<template>
	<view class="content">
		<view v-if="orderList.length<1"><text>贵店暂时无订单</text></view>
		<view class="order" v-for="(item,i) in orderList" :key='i'>
			<view class="head">
				<text style="float: left;">收货人：{{item.consignee}}</text><text style="float:right">电话：{{item.tel}}</text>
			</view>
			<view v-for="(tco,j) in item.tcoList" :key='j'>
				<view>
					<!--只拿到菜品编号，需要拿到菜品名称-->
					{{tco.cuisineName}}<text style="float: right;">x{{tco.quantity}}</text>
				</view>
			</view>
			<view class="foot">
				<text style="float: left;">地址：{{item.message}}</text>
				<view class="load-button" style="float: right;" @click="planButton(item)">
					<text v-if="item.orderStatus=='false'">新订单</text>
					<text v-else>已完成</text>
				</view>
				<text style="float: left;margin-top:20rpx">订单时间：{{item.orderTime}}</text>
			</view>
			<!--
				-->
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				orderList: []
			}
		},
		mounted() {
			this.Init()
		},
		methods: {
			Init(){
				let canteenId = uni.getStorageSync('canteen').canteenId
				uni.request({
					url: this.$baseUrl + "api/getCanteenOrder",
					method: 'post',
					data: {
						canteenId: canteenId
					},
					header: {
						'content-type': 'application/json'
					},
					success: res => {
						if (res.data.code == 200) {
							this.orderList = res.data.object;
						}
					}
				})
			},
			planButton(item){
				uni.request({
					url: this.$baseUrl + "api/editCanteenOrder",
					method: 'post',
					data: {
						orderId: item.orderId,
						orderStatus:item.orderStatus
					},
					header: {
						'content-type': 'application/json'
					},
					success: res => {
						if (res.data.code == 200) {
							setTimeout(() => {
								this.dialogToggle("修改成功");
								setTimeout(() => {
									uni.hideToast();
								}, 1000)
							}, 0);
						}
					}
				})
			},
			dialogToggle(type) {
				uni.showToast({
					title: type,
					icon: 'none', //如果要纯文本，不要icon，将值设为'none'
					duration: 2000 //持续时间为 2秒
				})
			}
		}
	}
</script>

<style>
	.content {
		display: flex;
		flex-direction: column;
		align-items: center;
		width: 100vw;
		height: 100vh;
		background-color: #F0F0F0;
	}

	.order {
		width: 80%;
		height: 26%;
		background-color: #E3EDCD;
		margin-top: 15px;
		padding: 0 20px;
		border-radius: 15px;
	}

	.head {
		border-bottom: 2px solid black;
		height: 30px;
	}

	.foot {
		border-top: 2px solid black;
		height: 30px;
		margin-top: 15px;
	}

	.load-button {
		width: 18%;
		height: 80%;
		box-sizing: border-box;
		float: left;
		margin-top: 2%;
		margin-left: 1%;
		border: 1px solid black;
		display: flex;
		justify-content: center;
		align-items: center;
	}
</style>
