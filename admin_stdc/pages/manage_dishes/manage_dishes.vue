<template>
	<view class="content">
		<view class="addBox">
			<view class="pickPic">
				<view class="add-btn">
					<!-- <image src="../../static/add-icon.png" style="width: 200rpx;height:200rpx;" @click="openFile"
						mode=""></image> -->
					<uni-file-picker v-model="imageValue" fileMediatype="image" mode="grid" limit="1" @select="upload"/>
				</view>

			</view>
			<view class="Traits">
				<view class="inputWrapper">
					<input class="input" type="text" placeholder="请输入菜名" v-model="cuisineName" />
				</view>
				<view class="inputWrapper">
					<input class="input" type="number" placeholder="请设置价格" v-model="cuisinePrice" />
				</view>
			</view>
			<view class="pickAndButton">
				<view class="inputWrapper">
					<input class="input" type="text" placeholder="类别" v-model="classes" />
				</view>
				<view class="load-button">
					<button class="button" type="primary" @tap="addSubmit">确定</button>
				</view>
			</view>
		</view>
		<scroll-view class="cuisineList" scroll-y="true" scroll-x="false">
			<view class="list" v-for="(item,i) in CuisineList" :key='i' :id="'item-'+i">
				<view class="title">
					{{item.classes}}
				</view>
				<view class="list_main" v-for="(items,j) in item.list" :key='j'>
					<img class="list_picBox" :src="items.picUrl">
					<view class="list_message">
						<view class="list_name">{{items.name}}</view>
						<view class="list_price">￥{{items.price}}</view>
					</view>
					<view class="list_edit">
						<view class="load-button1">
							<button class="button1" size="mini" type="primary"
								@tap="editButton(items,item.classes)">编辑</button>
						</view>
						<view class="delButton" @click="delButton(items)">
							<view v-if="items.status===1"><text>下架</text></view>
							<view v-else-if="items.status===0"><text>上架</text></view>
						</view>
					</view>
				</view>
			</view>
		</scroll-view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				cuisinePrice: '',
				classes: '',
				cuisineName: '',
				cuisineId: '',
				CuisineList: [],
				cuisinePicUrl:''
			}
		},
		mounted() {
			let canteenId = uni.getStorageSync('canteen').canteenId
			//console.log(JSON.stringify(user))
			uni.request({
				url: this.$baseUrl + "api/cuisineInit",
				method: 'post',
				data: {
					canteenId: canteenId
				},
				header: {
					'content-type': 'application/json'
				},
				success: res => {
					if (res.data.code == 200) {
						this.CuisineList = res.data.object;
					}
				}
			})
		},
		methods: {
			upload(e) {
				const tempFilePaths = e.tempFilePaths; //e是获取的图片源
				uni.uploadFile({
					url: this.$baseUrl + 'api/upload', //上传图片的后端接口
					filePath: tempFilePaths[0],
					name: 'file',
					success: res => {
						console.log(res.data)
						this.cuisinePicUrl = res.data
						console.log(this.cuisinePicUrl, "头像")
					}
				})
			},
			editButton(items, classes) {
				console.log(JSON.stringify(items))
				this.cuisinePrice = items.price;
				this.classes = classes;
				this.cuisineName = items.name;
				this.cuisineId = items.cuisineId;
			},
			addSubmit() {
				let canteenId = uni.getStorageSync('canteen').canteenId
				console.log(canteenId)
				uni.request({
					url: this.$baseUrl + "api/addCuisine",
					method: 'post',
					data: {
						cuisinePrice: this.cuisinePrice,
						classes: this.classes,
						cuisineName: this.cuisineName,
						canteenId: canteenId,
						cuisineId: this.cuisineId,
						cuisinePicUrl: this.cuisinePicUrl
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
								}, 1000)
							}, 0);
						} else if (res.data.code == 400) {
							setTimeout(() => {
								this.dialogToggle("失败");
								setTimeout(() => {
									uni.hideToast();
								}, 1000)
							}, 0);
						}
					}
				})
			},
			delButton(cuisine) {
				uni.request({
					url: this.$baseUrl + "api/delCuisine",
					method: 'post',
					data: {
						cuisineId: cuisine.cuisineId,
						status: cuisine.status
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
								}, 1000)
							}, 0);
						} else {
							setTimeout(() => {
								this.dialogToggle("失败");
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
		width: 100vh;
		height: 1140rpx;
		background-color: #fef9e7;
	}

	.addBox {
		width: 100%;
		height: 275rpx;

		/*border-style: solid;*/

		border-bottom: 2px solid black;
		padding-top: 25rpx;
	}

	.cuisineList {
		height: 850rpx;
		width: 1000rpx;
	}

	.pickPic {
		float: left;

		width: 225rpx;
		height: 225rpx;

		/*border-style: solid;*/
	}

	.title {
		padding-left: 20rpx;
	}

	.list {
		border-bottom: 2px solid black;
		width: 80%;

	}

	.list_main {
		width: 80%;
		height: 180rpx;
		/*border-style: solid;*/
		margin-top: 30rpx;
		margin-left: 50rpx;
		background-color: #CCFFFF;

		border-radius: 10px;
	}

	.list_picBox {
		float: left;
		width: 140rpx;
		height: 140rpx;
		margin-top: 10rpx;
		margin-left: 20rpx;
	}

	.list_message {
		height: 140rpx;
		width: 200rpx;
		/*border-style: solid;*/
		float: left;
		margin-top: 10rpx;
		margin-left: 10rpx;
	}


	.list_name {
		width: 130rpx;
		height: 60rpx;
	}

	.list_price {
		width: 130rpx;
		height: 60rpx;
	}

	.list_edit {
		height: 140rpx;
		float: left;
		width: 200rpx;
		margin-top: 10rpx;
		margin-left: 10rpx;
	}

	.Traits {
		float: left;

		width: 325rpx;
		height: 225rpx;

		border-left: 2px solid black;
		border-right: 2px solid black;
		/*border-style: solid;*/
	}

	.pickAndButton {
		float: left;
		width: 200rpx;
		height: 225rpx;

		/*border-style: solid;*/
	}

	.inputWrapper {
		width: 70%;
		height: 80rpx;
		background: white;
		box-sizing: border-box;
		margin-top: 20rpx;
		margin-left: 30rpx;
	}

	.inputWrapper .input {
		width: 100%;
		height: 100%;
		text-align: center;
		font-size: 15px;
	}

	.load-button {
		width: 70%;
		height: 80rpx;
		box-sizing: border-box;
	}

	.button {
		width: 100%;
		height: 80rpx;
		margin-top: 20rpx;
		margin-left: 20rpx;
	}

	.load-button1 {
		width: 70%;
		height: 50rpx;
	}

	.button1 {
		width: 100%;
		height: 50rpx;
		margin-top: 10rpx;
		margin-left: 20rpx;
	}

	.delButton {
		width: 100rpx;
		margin-top: 20rpx;
		margin-left: 20rpx;
		border: 1px solid black;
		display: flex;
		justify-content: center;
		align-items: center;
	}

	.add-btn {
		width: 200rpx;
		height: 200rpx;

	}
</style>