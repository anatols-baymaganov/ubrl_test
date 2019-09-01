# frozen_string_literal: true

class CreateAvgScoreTrigger < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE FUNCTION calculate_post_avg_score() RETURNS trigger AS $calculate_post_avg_score$
        BEGIN
          IF (TG_OP = 'INSERT') THEN
            UPDATE posts SET avg_score = (SELECT AVG(value) FROM scores WHERE post_id = NEW.post_id) WHERE id = NEW.post_id;
            RETURN NEW;
          ELSIF (TG_OP = 'UPDATE') THEN
            UPDATE posts SET avg_score = (SELECT AVG(value) FROM scores WHERE post_id = NEW.post_id) WHERE id = NEW.post_id;
            IF (NEW.post_id != OLD.post_id) THEN
              UPDATE posts SET avg_score = (SELECT AVG(value) FROM scores WHERE post_id = OLD.post_id) WHERE id = OLD.post_id;
            END IF;
            RETURN NEW;
          ELSIF (TG_OP = 'DELETE') THEN
            UPDATE posts SET avg_score = (SELECT AVG(value) FROM scores WHERE post_id = OLD.post_id) WHERE id = OLD.post_id;
            RETURN OLD;
          END IF;
        END;
      $calculate_post_avg_score$ LANGUAGE plpgsql;

      CREATE TRIGGER calculate_post_avg_score
      AFTER INSERT OR UPDATE OR DELETE
        ON scores
        FOR EACH ROW
          EXECUTE PROCEDURE calculate_post_avg_score();
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER calculate_post_avg_score ON scores CASCADE;
      DROP FUNCTION calculate_post_avg_score() CASCADE;
    SQL
  end
end
