class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      #relationshipsテーブルは中間テーブルなので　t.referenceで作る必要がある。
      t.references :user, foreign_key: true
      t.references :follow, foreign_key: { to_table: :users }

      t.timestamps

      #ペアで重複するものが保存されないようにするデータベースの設定
      t.index [:user_id, :follow_id], unique: true
    end
  end
end
