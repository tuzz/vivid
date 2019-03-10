module Vivid
  class Exec
    def self.pbrt(path:)
      system("pbrt #{Config.pbrt_flags} #{path}")
    end

    def self.ffmpeg(input:, output:, rate:)
      in_flags = Config.ffmpeg_in_flags
      out_flags = Config.ffmpeg_out_flags

      system("ffmpeg -r #{rate} #{in_flags} -i #{input} #{out_flags} #{output}")
    end

    def self.md5(path:)
      `md5 -q #{path}`.strip
    end
  end
end
