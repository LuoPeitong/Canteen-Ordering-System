<template>
	<view class="container">
		<view class="head">
			<text>{{user.studentNo}} {{user.name}} 余额: {{user.balance}}</text>
		</view>
		<view>
			<view class="position-group">
				<!-- 一级循环 -->
				<view class="pronames_one" v-for="(item,index) in positionlist" :key="index"
					:class="item.listStare?'oneshow':'onehide'">
					<view class="pronames-one-label" @click="onelist(index)">
						<text>{{item.location}}</text>
						<label :class="item.listStare?'cuIcon-fold':'cuIcon-unfold'"></label>
					</view>
					<!-- 二级循环 -->
					<view class="pronames_two" v-for="(item2,index2) in item.canteenList" :key="index2">
						<view class="pronames-two-label" @click="twolist(index,index2)">
							<text>{{item2.floor}}</text>
							<!--<label :class="item2.twoliststare?'cuIcon-fold':'cuIcon-unfold'"></label>-->
							<label></label>
						</view>
					</view>
				</view>

			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				user: {
					username: '',
					name: '',
					balance: 0,
					studentNo: ''
				},
				positionSele: true,
				positionlist: []
			}
		},
		methods: {
			onelist(index) {
				let positionlist = this.positionlist;
				// 展开收起一级列表 start
				if (positionlist[index]['listStare'] == false) {
					positionlist[index]['listStare'] = true;
				} else {
					positionlist[index]['listStare'] = false;
				}
				// 展开收起一级列表 end
			},

			twolist(index, index2) {
				let positionlist = this.positionlist;
				//跳转去点菜页面
				uni.navigateTo({
					url: '../order/order?canteen=' + positionlist[index].location + '&floor=' + positionlist[index]
						.canteenList[index2].floor + '&canteenId=' + positionlist[index]
						.canteenList[index2].canteenId
				})
			}
		},
		// 一进来就执行的东西
		onLoad() {
			this.user = uni.getStorageSync('user');
			uni.request({
				url: this.$baseUrl + "api/getCanteen",
				method: 'post',
				header: {
					'content-type': 'application/json'
				},
				success: res => {
					if (res.data.code == 200) {
						this.positionlist = res.data.object;
					}
				}
			})
		},
		onshow() {
			this.user = uni.getStorageSync('user');
		}
	}
</script>

<style>
	.container {
		background-color: #F0F0F0;
	}

	.head {
		height: 25px;
	}

	.uni-margin-wrap {
		width: 100%;
	}

	.swiper {
		height: 200px;
	}

	.swiper-item {
		/* #ifndef APP-NVUE */
		display: flex;
		/* #endif */
		flex-direction: column;
		justify-content: center;
		align-items: center;
		background-color: $uni-text-color-grey;
		color: #fff;
	}

	.image {
		width: 750rpx;
	}


	.position-group {
		width: 100%;
		height: auto;
	}

	/* 一级 */
	.pronames_one {
		width: 100%;
		height: auto;
	}

	.pronames-one-label {
		width: 100%;
		height: 110rpx;
		line-height: 110rpx;
		background: #fff;
		box-sizing: border-box;
		padding: 0px 3%;
		display: flex;
		flex-direction: row;
		justify-content: space-between;
		align-items: center;
		border-bottom: 1px #eaeaea solid;
	}

	.pronames-one-label text {
		font-size: 15px;
		color: #2ebbfe;
	}

	.pronames-one-label label {
		color: #aaa;
		font-size: 20px;
		transition: all 0.5s;
	}

	/* 二级 */
	.pronames_two {
		width: 100%;
		height: auto;
		transition: all 0.5s;
	}

	.pronames-two-label {
		width: 100%;
		height: 110rpx;
		line-height: 110rpx;
		display: flex;
		flex-direction: row;
		justify-content: space-between;
		box-sizing: border-box;
		padding: 0px 3%;
		border-bottom: 1px #eee solid;
	}

	.pronames-two-label text {
		font-size: 15px;
		color: #333;
	}

	.pronames-two-label label {
		color: #aaa;
		font-size: 20px;
		transition: all 0.5s;
	}

	/* 展开收起效果 start */

	.oneshow .pronames_two {
		display: block;
	}

	.onehide .pronames_two {
		display: none;
	}

	/* 展开收起效果 end */
	/*.twoshow .pronames_three {display: block;}*/
	/*.twohide .pronames_three {display: none;}*/
</style>