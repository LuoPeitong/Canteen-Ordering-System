<template>
	<view class="container">
		<view class="head">
			<text>{{user.studentNo}} {{user.name}} 余额: {{user.balance}}</text>
		</view>
		<view class="uni-margin-wrap">
			<swiper class="swiper" circular indicator-dots="true" autoplay="true" interval="3000" duration="500">
				<swiper-item v-for="(item, index) in info" :key="index">
					<view class="swiper-item">
						<image class="image" :src="item.url" mode="center" @click="onBanner(index)" />
					</view>
				</swiper-item>
			</swiper>
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
					<!--<view class="pronames_two" v-for="(item2,index2) in item.positiontwo" :key="index2"
						:class="item2.twoliststare?'twoshow':'twohide'">-->
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
				info: [{
						url: 'https://vkceyugu.cdn.bspapp.com/VKCEYUGU-dc-site/094a9dc0-50c0-11eb-b680-7980c8a877b8.jpg',
						content: '内容 A'
					},
					{
						url: 'https://vkceyugu.cdn.bspapp.com/VKCEYUGU-dc-site/094a9dc0-50c0-11eb-b680-7980c8a877b8.jpg',
						content: '内容 B'
					},
					{
						url: 'https://vkceyugu.cdn.bspapp.com/VKCEYUGU-dc-site/094a9dc0-50c0-11eb-b680-7980c8a877b8.jpg',
						content: '内容 C'
					}
				],
				positionSele: true,
				positionlist: []
				//positionlist: [{id: 0,onename: "北区食堂",oneliststare: false,positiontwo: [{twoid: 0,twoname: "一楼自选餐厅",//twoliststare: false}, {twoid: 1,twoname: "二楼自助餐厅",//twoliststare: false}, {twoid: 2,twoname: "三楼小吃城",//twoliststare: false}, {twoid: 3,twoname: "四楼清真食堂",//twoliststare: false}]}, {id: 1,onename: "中区食堂",oneliststare: false,positiontwo: [{twoid: 0,twoname: "一楼餐厅",//twoliststare: false}, {twoid: 1,twoname: "二楼餐厅",//twoliststare: false}]}]
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
			},
			//轮播图点击事件
			onBanner(index) {
				//console.log(22222, index);
			},

		},
		// 一进来就执行的东西
		onLoad() {
			this.user = uni.getStorageSync('user');
			uni.request({
				url: "http://localhost:80/api/getCanteen",
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
