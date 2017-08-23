class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

    has_many :wants
    has_many :records, through: :wants
    has_many :findings, through: :records


  def findings?
    findings = []
    self.records.each do |record|
      record.findings
    end
  end

  def index
  end

end
