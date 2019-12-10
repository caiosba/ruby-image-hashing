require 'dhash-vips'
require 'phashion'

class Algorithm
  def self.idhash(a, b)
    hash1 = DHashVips::IDHash.fingerprint a
    hash2 = DHashVips::IDHash.fingerprint b
    distance = DHashVips::IDHash.distance hash1, hash2
    distance < 25 ? 'Similar' : 'Different'
  end

  def self.dhash(a, b)
    hash1 = DHashVips::IDHash.fingerprint a
    hash2 = DHashVips::IDHash.fingerprint b
    distance = DHashVips::DHash.hamming hash1, hash2
    distance < 50 ? 'Similar' : 'Different'
  end

  def self.phash(a, b)
    img1 = Phashion::Image.new(a)
    img2 = Phashion::Image.new(b)
    img1.duplicate?(img2, threshold: 18) ? 'Similar' : 'Different'
  end

  def self.pdq(a, b)
    diff = `python3.6 ./pdq/pdqhashing/tools/compare.py #{a} #{b}`
    diff.to_i < 110 ? 'Similar' : 'Different'
  end
end

%w(pdq phash idhash dhash).each do |algorithm|
  puts "Evaluating #{algorithm}..."
  total = 0
  t0 = Time.now.to_f
  
  false_positive = []
  false_negative = []
  data = { 'False Positives' => 0, 'True Positives' => 0, 'False Negatives' => 0, 'True Negatives' => 0 }
  Dir.glob("datasets/goldengate/*").to_a.sort.each do |file|
    b = file
    a = "datasets/goldengate/original.png"
    next if b == a
    match = Algorithm.send(algorithm, a, b)
    # data[b] = match
    if match == 'Similar'
      data['True Positives'] += 1 unless b =~ /diff/
      data['False Positives'] += 1 if b =~ /diff/
      false_positive << File.basename(b) if b =~ /diff/
    else
      data['True Negatives'] += 1 if b =~ /diff/
      data['False Negatives'] += 1 unless b =~ /diff/
      false_negative << File.basename(b) unless b =~ /diff/
    end
    total += 1
  end
  
  t1 = Time.now.to_f
  puts '********************************************************************************************'
  puts "Results for #{algorithm}"
  data.each do |key, value|
    puts "#{key}: #{value}#{ (key == 'False Positives' && false_positive.size > 0) ? (' (' + false_positive.join(', ') + ') ') : ( (key == 'False Negatives' && false_negative.size > 0) ? (' (' + false_negative.join(', ') + ') ') : ' ') }(#{((value.to_f / (total.to_f / 2)) * 100).round(2)}%)"
  end
  puts "Total: #{total}"
  puts "Time: #{(t1 - t0).round(2)} seconds"
  puts '********************************************************************************************'
end
