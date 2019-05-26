
class RubyTraining

    def self.generate_matrix
        # 行を合計値を算出する
        matrix = generate_data.map { |row|
            row_sum = 0
            row.each { |n|
                row_sum += n.to_i
            }
            row << row_sum.to_s
        }

        # 列を合計値を算出する
        matrix << matrix.transpose.map { |col|
            col_sum = 0
            col.each { |n| col_sum += n.to_i }
            col_sum.to_s
        }

        # 表に出力する
        matrix.map { |row|
            row.map { |n| n.rjust(5) }.join("|")
        }.join("\n")
    end

    def self.generate_data
        data = 5.times.map {
            4.times.map { rand(999).to_s }
        }
    end
end

# 以下テストコード

describe 'generate_matrix' do

    matrix =  RubyTraining.generate_matrix
    rows = matrix.split("\n")
    table = rows.map { |n| n.split("|") }
    numbers_by_cols = table.transpose.map { |col|
        col.map { |n| n.strip.to_i }
    }
    puts matrix

    it '5列であること' do
        rows.each do |n|
            expect(n.split("|").size).to eq 5
        end
    end

    it '6行であること' do
        expect(rows.size).to eq 6
    end

    it '数値が右詰めであること' do
        table.flatten.each do |n|
            expect(n).to match /^\s*\d+$/
        end
    end

    it '行の合計値が正しいこと' do
        table.each do |row|
            sum = 0
            row[0..3].each { |n| sum += n.strip.to_i}
            expect(sum).to eq row[-1].strip.to_i
        end
    end

    it '列の合計値が正しいこと' do
        numbers_by_cols.each do |col|
            sum = 0
            col[0..4].each { |n| sum += n }
            expect(sum).to eq col[-1]
        end
    end

    it '数値がランダムで生成されること' do
        matrix_arr = 10.times.map { RubyTraining.generate_matrix }
        expect(matrix_arr.uniq).to eq matrix_arr
    end
end