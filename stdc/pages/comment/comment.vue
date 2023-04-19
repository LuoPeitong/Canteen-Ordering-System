<template>
	<view class="content">
		<view v-if="commentList.length<1"><text>你没有进行过评论~</text></view>
		<view class="commentList" v-for="(item,i) in commentList" :key='i'>
			<view class="top">
				<view class="top_left">
					<image style="width:100%; height:100%; " :src="item.canteenPicUrl" mode="aspectFill"></image>
				</view>
				<view class="top_right">
					<view class="top_right_first">
						<view style="margin-left:5%;"><text>{{item.location}}·{{item.floor}}</text></view>
					</view>
					<view class="tpo_right_second">
						<uni-rate style="margin-left:5%;" :max="5" :readonly="true" v-model="item.comment" />
						<!--<view style="margin-left:5%;"><text v-for="count in item.comment">⭐</text></view>-->
					</view>
				</view>
			</view>

			<view class="text-box" scroll-y="true">
				<text>{{item.content}}</text>
			</view>
			
			<view class="foot">
				<view class="load-button" @click="delButton(item.commentId)">
					<text>删除</text>
				</view>
				<view class="time">{{item.commentTime}}</view>
			</view>

		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				commentList: []
			}
		},
		mounted() {
			var user = uni.getStorageSync('user');
			uni.request({
				url: this.$baseUrl + "api/getListByUser",
				method: 'post',
				data: {
					userId: user.userId
				},
				header: {
					'content-type': 'application/json'
				},
				success: res => {
					if (res.data.code == 200) {
						//console.log(JSON.stringify(res.data.object))
						this.commentList = res.data.object
					}
				}
			})
		},
		methods: {
			delButton(value){
				console.log(value);
				uni.request({
					url: this.$baseUrl + "api/delComment",
					method: 'post',
					data: {
						commentId:value
					},
					header: {
						'content-type': 'application/json'
					},
					success: res => {
						if (res.data.code == 200) {
							//console.log(JSON.stringify(res.data.object))
							console.log("删除成功");
							location.reload();
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
		height: 100vh;
		background-color: #F0F0F0;
	}

	.commentList {
		width: 90%;
		height: 32vh;
		margin-top: 10px;
		margin-bottom: 10px;
		border-bottom: 2px solid black;
		border-top: 1px solid black;
		
	}

	.top {
		width: 100%;
		height: 29%;
		margin-top: 5px;
	}

	.top_left {
		width: 20%;
		height: 100%;
		float: left;
		margin-left: 3%;
	}

	.top_right {
		width: 75%;
		height: 100%;
		float: left;
	}

	.top_right_first {
		width: 100%;
		height: 50%;
	}

	.tpo_right_second {
		width: 100%;
		height: 50%;
	}

	.text-box {
		margin-top: 10px;
		display: flex;
		height: 50%;
		background-color: #FFFFFF;
		justify-content: center;
		align-items: center;
		text-align: center;
		font-size: 30rpx;
		color: #353535;
		line-height: 1.8;
		border-radius: 10px;
	}
	
	.foot{
		width:100%;
		height:25%;
		/*border: 1px solid black;*/
	}
	
	.load-button {
		width: 10%;
		height: 22px;
		float:left;
		margin-left: 3%;
		margin-top: 2%;
		border: 1px solid black;
		padding:0 10px;
	}
	
	.time{
		float:right;
		margin-top: 2%;
		margin-right: 3%;
	}
</style>
