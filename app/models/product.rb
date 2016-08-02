class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :name
  field :type
  field :length, type: Integer
  field :width, type: Integer
  field :height, type: Integer
  field :weight, type: Integer

  slug :name

  validates_presence_of :name, :type, :length, :width, :height, :weight
  validates_uniqueness_of :name
  validates_numericality_of :length, :width, :height, :weight

  scope :product_length, ->(l) { where(:length.gte => l).order_by(length: :asc) }
  scope :product_width, ->(w) { where(:width.gte => w).order_by(width: :asc) }
  scope :product_height, ->(h) { where(:height.gte => h).order_by(height: :asc) }
  scope :product_weight, ->(w) { where(:weight.gte => w).order_by(weight: :asc) }

  def self.dimensions length, width, height, weight
    self.product_length(length).product_width(width).product_height(height).product_weight(weight).first
  end
end
