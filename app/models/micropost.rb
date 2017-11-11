class Micropost < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  
  has_many :favorites , dependent: :destroy
  has_many :liking_users, through: :favorites, source: :user

  # 正規表現は複雑ですが、文字列の中から URL を特定して、そこに <a></a> を追加する処理です
  # データベースに入っている値 `content` を変換して返却するので `content_with_links` というメソッド名にしました
  # ただし、このままだと文字列として表示されるため、View 側で raw を使うと良いです
  # 【例】<%= raw micropost.content_with_links %>
  def content_with_links()
    return self.content if !self.content.include?('http')
    uri_reg = URI.regexp(%w[http https])
    self.content.gsub!(uri_reg) {%Q{<a href="#{$&}">#{$&}</a>}}
  end
end