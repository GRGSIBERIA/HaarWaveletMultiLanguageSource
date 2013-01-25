# encoding: utf-8

# Haarのウェーブレット解析をするためのクラス
class HaarWavelet
  # @param [Array<Float>] wave 波形
  # @param [Integer] scale_size スケールの大きさ, 2以上を指定
  def initialize(wave, scale_size)
  	@wave = wave
  	@length = Array.new(scale_size)
  	@length[0] = @wave
  	@weight = Array.new(scale_size)
  	@weight[0] = Array.new(@wave.length, 0)
  	CalcScale()
  end

  def CalcScale()
  	for i in 1..@length.length-1 do
  		prev_wave = @length[i-1]
  		now_length = Array.new(prev_wave.length >> 1)
  		now_weight = Array.new(now_length.length)

  		for j in 0..now_length.length-1 do
  			weight = (prev_wave[j*2] - prev_wave[j*2+1]).abs * 0.5
  			length = prev_wave[j*2] < prev_wave[j*2+1] ?
  				prev_wave[j*2] + weight : prev_wave[j*2+1] + weight
  			now_length[j] = length
  			now_weight[j] = weight
  		end
  		@length[i] = now_length
  		@weight[i] = now_weight
  	end
  end

  # 長さを返す
  # @return [Array<Float>] スケールごとの長さ
  def Length(scale)
  	return @length[scale]
  end

  # 重みを返す
  # @return [Array<Float>] スケールごとの重み
  def Weight(scale)
  	return @weight[scale]
  end
end
