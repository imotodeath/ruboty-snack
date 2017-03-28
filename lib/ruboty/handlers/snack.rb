require "ruboty"
require "pp"

module Ruboty
  module Handlers
    class Snack < Base
      OYATSU = %w(
        🌰 🍏 🍎 🍐 🍊 🍋 🍌 🍉 🍇 🍓 🍈 🍒 🍑 🍍 🍅
        🍆 🌽 🍠 🍞 🧀 🍗 🍖 🍤 🍳 🍟 🌭 🍕 🍝 🌮 🌯
        🍜 🍲 🍥 🍣 🍱 🍛 🍙 🍚 🍘 🍢 🍡 🍧 🍨 🍦 🍰
        🎂 🍮 🍬 🍭 🍫 🍿 🍩 🍪 🍄 🥝 🥑 🥒 🥕 🌶 🥔
        🥜 🥐 🥖 🥚 🥓 🥞 🍔 🥙 🥗 🥘
      )

      on(
        /お腹(?<status>.+)/,
        name: "feed",
        description: "Gives you some snacks"
      )

      on(
        /(harahe|はらへ|ハラへ|ﾊﾗﾍ|ハラヘ)/,
        name: "feed_snack",
        description: "Gives you some snacks",
        all: true
      )

      def feed(message)
        esa =
          case message[:status]
          when /すい/, /空/, /へっ/, /減/, /すき/,
               /ペコペコ/, /ぺこぺこ/
            oyatsu
          when /痛い/, /いたい/
            "💊"
          when /いっぱい/, /ぱんぱん/, /パンパン/, /く/, /苦/
            "☕"
          end
        message.reply("#{mention(message)}つ#{esa}")
      end

      def feed_snack(message)
        message.reply("#{mention(message)}つ#{oyatsu}")
      end

      private

      def mention(message)
        "@#{message.from}" if ENV["MENTION"] == "1"
      end

      private

      def oyatsu
        OYATSU.sample
      end
    end
  end
end
