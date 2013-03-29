module SimpleComment
  class Comment < ActiveRecord::Base
    belongs_to :commentable, polymorphic: true

    belongs_to :reply_comment,
               class_name:  'SimpleComment::Comment',
               foreign_key: :reply_comment_id

    validates  :commentable, presence: true
    validates  :content,     presence: true
    validates  :reply_comment_creator,
               presence: {if: Proc.new {|comment| !comment.reply_comment.blank?}}

    default_scope order('id DESC')
  end
end
