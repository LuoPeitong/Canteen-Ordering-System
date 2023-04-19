<template>
	<view class="content">
		<view class="inputWrapper">
			<input class="input" placeholder="请填写收货地址" type="text" v-model="address.message" />
		</view>

		<view class="inputWrapper">
			<input class="input" placeholder="请填写收货人" type="text" v-model="address.consignee" />
		</view>

		<view class="inputWrapper">
			<input class="input" placeholder="请填写收货人号码" type="text" v-model="address.tel" />
		</view>
		<!--v-if="carts.length<1"-->
		<view class="load-button">
			<button class="load-button-style" style="float: left;" type="primary" @tap="editButton">确定</button>
			<button v-if="!address.addressId==''" class="load-button-style"  style="float: right;"type="warn" @tap="delButton">删除</button>
		</view>
		
	</view>
</template>

<script>
	export default {
		data() {
			return {
				address: {}
			}
		},
		onLoad(option) {
			console.log(JSON.stringify(option))
			if(JSON.stringify(option)=="{}")
			{
				var user = uni.getStorageSync('user');
				this.address.userId = user.userId
			}
			else{
				var data = JSON.parse(option.address);
				this.address = data;
			}
			//console.log(JSON.stringify(this.address))
		},
		methods: {
			dialogToggle(type) {
				uni.showToast({
					title: type,
					icon: 'none', //如果要纯文本，不要icon，将值设为'none'
					duration: 2000 //持续时间为 2秒
				})
			},
			editButton() {
				uni.request({
					url: this.$baseUrl + "api/addAddress",
					method: 'post',
					data: {
						addressId: this.address.addressId,
						userId: this.address.userId,
						message: this.address.message,
						consignee: this.address.consignee,
						tel: this.address.tel
					},
					header: {
						'content-type': 'application/json'
					},
					success: res => {
						if (res.data.code == 200) {
							setTimeout(() => {
								this.dialogToggle(res.data.message);
								setTimeout(() => {
									uni.hideToast();
									//关闭提示后跳转
									uni.navigateTo({
										url: '/pages/address/address'
									});
								}, 1000)
							}, 0);
						}
					}
				})
			},
			delButton() {
				uni.request({
					url: this.$baseUrl + "api/delAddress",
					method: 'post',
					data: {
						addressId: this.address.addressId
					},
					header: {
						'content-type': 'application/json'
					},
					success: res => {
						if (res.data.code == 200) {
							setTimeout(() => {
								this.dialogToggle(res.data.message);
								setTimeout(() => {
									uni.hideToast();
									//关闭提示后跳转
									uni.navigateTo({
										url: '/pages/address/address'
									});
								}, 1000)
							}, 0);
						}
					}
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
		height: 93vh;
		background-color: #F0F0F0;
	}

	.inputWrapper {
		width: 70%;
		height: 80upx;
		background: white;
		border-radius: 20px;
		box-sizing: border-box;
		padding: 0 20px;
		margin-top: 25px;
	}

	.inputWrapper .input {
		width: 100%;
		height: 100%;
		text-align: left;
		font-size: 15px;
	}

	.load-button {
		width: 40%;
		height: 80upx;
		box-sizing: border-box;
		margin-top: 15px;
	}

	.button {
		width: 100%;
		height: 80upx;
		border-radius: 20px;
		box-sizing: border-box;
		display: flex;
		justify-content: center;
		align-items: center;
		margin-top: 25px;
	}
</style>
