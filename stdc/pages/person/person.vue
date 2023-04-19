<template>
	<view class="container">
		<view class="top">
			<view class="up">
				<view class="name">姓名:{{user.name}}</view>
				<view class="logOut" @click="logOut" style="text-decoration:underline"> 退出登录</view>
			</view>
			<view class="down">
				<view class="balance">余额:¥{{user.balance}}</view>
				<view class="recharge" @click="inputDialogToggle" style="text-decoration:underline">充值</view>
			</view>
			<view>
				<!-- 输入框示例 -->
				<uni-popup ref="inputDialog" type="dialog">
					<uni-popup-dialog ref="inputClose" mode="input" title="余额充值" value="" placeholder="请输入金额"
						@confirm="dialogInputConfirm"></uni-popup-dialog>
				</uni-popup>
			</view>
		</view>
		<view class="buttom">
			<view class="function" @click="gotoDingdan">
				<image src="/static/icon/order.png"></image>
				<text style="align-right">订单</text>
			</view>
			<view class="function" @click="gotoAddress">
				<image src="/static/icon//address.png"></image>
				<text style="align-right">地址</text>
			</view>
			<view class="function" @click="gotoComment">
				<image src="/static/icon//evaluate.png"></image>
				<text style="align-right">评价</text>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				user: {}
			}
		},
		mounted() {
			this.user = uni.getStorageSync('user');
		},
		methods: {
			logOut() {
				uni.removeStorageSync('user')
				uni.removeStorageSync('carts')
				uni.reLaunch({
					url: '../login/login'
				});
			},
			inputDialogToggle() {
				this.$refs.inputDialog.open()
			},
			dialogInputConfirm(val) {
				this.user.balance += val * 1.0;
				//console.log(this.user.balance);
				//console.log(JSON.stringify(this.user))
				uni.request({
					url: "http://localhost:80/api/recharge",
					method: 'post',
					data: {
						userId: this.user.userId,
						balance: this.user.balance
					},
					header: {
						'content-type': 'application/json'
					},
					success: res => {
						if (res.data.code == 200) {
							this.user = res.data.object;
							uni.setStorageSync('user', this.user);
							setTimeout(() => {
								this.dialogToggle("充值成功");
								setTimeout(() => {
									// 关闭窗口后，恢复默认内容
									this.$refs.inputDialog.close()
								}, 2000)
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
			},
			gotoDingdan() {
				uni.navigateTo({
					url: '/pages/dingdan/dingdan'
				});
			},
			gotoAddress() {
				uni.navigateTo({
					url:'/pages/address/address'
				});
			},
			gotoComment() {
				uni.navigateTo({
					url: '/pages/comment/comment'
				});
			}
		}
	}
</script>

<style>
	.container {
		/*能够扩展和收缩 flex 容器内的元素，以最大限度地填充可用空间。*/
		display: flex;
		/*主轴为垂直方向，起点在上沿。（从上往下）*/
		flex-direction: column;
		/*将弹性 <div> 元素的所有项目的居中对齐：*/
		align-items: center;
		/*在容器中央对齐弹性项目：*/
		justify-content: center;
		background-color: #F0F0F0;
	}

	.top {
		margin-top: 10px;
		width: 90%;
		height: 80px;
		border-radius: 10px;
		background-color: #F9F9F9;
	}

	.up {
		width: 100%;
		height: 50%;
	}

	.down {
		width: 100%;
		height: 50%;
	}

	.buttom {
		margin-top: 20px;
		width: 90%;
		height: 450px;
		border-radius: 10px;
		background-color: #F9F9F9;
	}

	.name {
		width: 120px;
		height: 30px;
		float: left;
		margin-left: 10px;
	}

	.logOut {
		width: 70px;
		height: 30px;

		float: right;
		margin-right: 10px;
	}

	.balance {
		width: 100px;
		height: 30px;
		float: left;
		margin-left: 10px;
	}

	.recharge {
		width: 50px;
		height: 30px;
		float: right;
		margin-right: 10px;

	}

	.function {
		width: 80%;
		height: 60px;
		margin-left: 10%;
		margin-top: 15px;

		border-radius: 10px;
		background-color: #F0F0F0;
	}

	image {
		margin-top: 10px;
		margin-left: 10px;
		width: 40px;
		height: 40px;
	}
</style>
