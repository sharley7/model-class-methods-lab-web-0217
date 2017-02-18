class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications

  def self.catamaran_operators
    Captain.joins(boats: :classifications).where(classifications: {name: "Catamaran"}
    )
  end

  def self.with_classifications
    joins(boats: :classifications)
  end

  def self.motorboaters
     with_classifications.where(classifications: {name:"Motorboat"})
  end

  def self.sailors
     with_classifications.where(classifications: {name: "Sailboat"}).uniq
  end

  def self.talented_seamen
     where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
 end

 def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end


end
