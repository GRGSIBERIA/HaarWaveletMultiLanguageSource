using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace HaarWaveletCS
{
	/// <summary>
	/// Haarのウェーブレットを表すクラス
	/// </summary>
	class HaarWavelet
	{
		private float[] wave;
		private uint scale_size;

		private List<float[]> weight;
		private List<float[]> differernce;

		/// <summary>
		/// 入力信号をコンストラクタの段階でウェーブレット解析する
		/// </summary>
		/// <param name="wave">入力信号の配列</param>
		/// <param name="scale_size">解析するスケールの大きさ</param>
		public HaarWavelet(float[] wave, uint scale_size)
		{
			this.wave = wave;
			this.scale_size = scale_size;

			this.weight = new List<float[]>();
			this.weight.Add(new float[this.wave.Length]);

			this.differernce = new List<float[]>();
			this.differernce.Add(wave);
		}

		/// <summary>
		/// Wavelet解析をするクラス
		/// </summary>
		private void AnalyzeWavelet()
		{
			for (int i = 1; i < this.scale_size; i++)
			{
				int now_size = this.weight[i - 1].Length >> 1;
				float[] now_weight = new float[now_size];
				float[] now_difference = new float[now_size];

				for (int j = 0; j < now_size; j++)
				{
					now_weight[j] =
						(this.differernce[i - 1][j * 2] + this.differernce[i - 1][j * 2 + 1]) * 0.5f;
					now_difference[j] =
						this.differernce[i - 1][j * 2] - now_weight[j];
				}

				this.weight.Add(now_weight);
				this.differernce.Add(now_difference);
			}
		}

		/// <summary>
		/// 重みを返す
		/// </summary>
		/// <param name="scale">スケール</param>
		/// <returns>スケールに対応した重み</returns>
		public float[] Weight(int scale)
		{
			return this.weight[scale];
		}

		/// <summary>
		/// 差分を返す
		/// </summary>
		/// <param name="scale">スケール</param>
		/// <returns>スケールに対応した差分</returns>
		public float[] Difference(int scale)
		{
			return this.differernce[scale];
		}
	}
}
