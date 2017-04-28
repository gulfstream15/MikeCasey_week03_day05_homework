require('PG')

class SqlRunner

  def SqlRunner.run( sql )
    begin
      db = PG.connect({ dbname: 'codeclan_cinema', host: 'localhost' })
      result = db.exec( sql )
    ensure
      db.close
    end
    return result
  end

end