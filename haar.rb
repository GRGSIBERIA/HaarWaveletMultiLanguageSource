# encoding: utf-8

# Haarのウェーブレット解析をするためのクラス
class HaarWavelet
  # @param [Array<Float>] wave 波形
  # @param [Integer] scale_size スケールの大きさ, 2以上を指定
  def initialize(wave, scale_size)
    @wave = wave
    @difference = Array.new(scale_size)
    @difference[0] = @wave
    @weight = Array.new(scale_size)
    @weight[0] = Array.new(@wave.length, 0)
    CalcScale()
  end

  def CalcScale()
    for i in 1..@difference.length-1 do
      prev_wave = @difference[i-1]
      now_difference = Array.new(prev_wave.length >> 1)
      now_weight = Array.new(now_difference.length)

      for j in 0..now_difference.length-1 do
        weight = (prev_wave[j*2] - prev_wave[j*2+1]) * 0.5
        difference = prev_wave[j*2] - weight
        now_difference[j] = difference
        now_weight[j] = weight
      end
      @difference[i] = now_difference
      @weight[i] = now_weight
    end
  end

  # 長さを返す
  # @return [Array<Float>] スケールごとの長さ
  def Difference(scale)
    return @difference[scale]
  end

  # 重みを返す
  # @return [Array<Float>] スケールごとの重み
  def Weight(scale)
    return @weight[scale]
  end
end
