<template>
	<view class="container">
		<!-- 设置评分数 -->
		<view class="head">
			<view class="head_left"><text>评分</text></view>
			<view class="head_right">
				<uni-rate :max="5" v-model="comment" />
			</view>
		</view>

		<view class="comment">
			<textarea class="textareaInput" placeholder="在此处编写评论" v-model="content" cols="30" maxlength="500" rows="6">
						</textarea>
		</view>
		<view class="load-button">
			<button class="button" type="primary" @tap="commentButton">提交</button>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				content: '',
				comment: '',
				orderId: '',
			}
		},
		onLoad(option) {
			var data = JSON.parse(option.orderId);
			this.orderId = data;
		},
		methods: {
			commentButton(value) {
				var user = uni.getStorageSync('user');
				uni.request({
					url: "http://localhost:80/api/addComment",
					method: 'post',
					data: {
						userId: user.userId,
						comment: this.comment,
						content: this.content,
						orderId: this.orderId
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
									uni.navigateBack({
										delta: 1
									});
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
	.container {
		display: flex;
		flex-direction: column;
		align-items: center;
		width: 100vw;
		height: 100vh;
		background-color: #F0F0F0;
	}

	.head {
		width: 90%;
		height: 10%;
		background: white;
		border-radius: 5px;
		margin-top: 10px;
	}

	.head_left {
		float: left;
		margin-top: 5%;
		margin-left: 5%;
	}

	.head_right {
		margin-top: 5%;
		margin-left: 5%;
		float: left;
	}

	.comment {
		width: 90%;
		height: 60vh;
		background: white;
		border-radius: 5px;
		box-sizing: border-box;
		padding: 0 20px;
		margin-top: 25px;
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
