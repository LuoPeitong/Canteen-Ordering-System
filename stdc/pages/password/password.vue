<template>
	<view class="content">
		<view class="inputWrapper">
			<input class="input" type="text" placeholder="请输入登录密码" v-model="password" />
		</view>
		<view class="inputWrapper">
			<input class="input" type="password" placeholder="请输入支付密码" v-model="payPassword" />
		</view>
		<view class="load-button">
			<button class="button" type="primary" @tap="editPassword">提交修改</button>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				password: '',
				payPassword: ''
			}
		},
		methods: {
			editPassword() {
				let user = uni.getStorageSync('user');
				uni.request({
					url: this.$baseUrl + "api/editPassword",
					method: 'post',
					data: {
						password:this.password,
						payPassword: this.payPassword,
						userId:user.userId
					},
					header: {
						'content-type': 'application/json'
					},
					success: res => {
						if (res.data.code == 200) {
							this.user = res.data.object;
							uni.setStorageSync('user', this.user);
							setTimeout(() => {
								this.dialogToggle("设置成功");
								setTimeout(() => {
									uni.switchTab({
										url: '../person/person'
									});
								}, 2000)
							}, 0);
							
						} else if (res.data.code == 201) {
							setTimeout(() => {
								this.dialogToggle(res.data.message);
								setTimeout(() => {
								}, 2000)
							}, 0);
						}
						else{
							setTimeout(() => {
								this.dialogToggle(res.data.message);
								setTimeout(() => {
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
		}
	}
</script>

<style>
	.content {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		width: 100vw;
		height: 100vh;
		background-color: bisque;
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
		width: 70%;
		height: 80upx;
		box-sizing: border-box;
		padding: 0 20px;
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
