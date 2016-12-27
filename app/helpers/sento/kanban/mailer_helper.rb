module Sento
  module Kanban
    module MailerHelper
      def p(text, options = {})
        options[:font_size] ||= '14px'
        options[:color] ||= '#aaaaaa'
        options[:text_align] ||= 'left'
        options[:bold] ||= false
        <<~HEREDOC
          <table cellpadding="0" cellspacing="0" width="100%" style="border-spacing: 0;border-collapse: collapse;vertical-align: top">
            <tbody>
              <tr style="vertical-align: top">
                <td style="word-break: break-word;border-collapse: collapse !important;vertical-align: top;padding-top: 15px;padding-right: 10px;padding-bottom: 10px;padding-left: 10px">
                  <div style="color: #aaaaaa;line-height: 120%;font-family: Arial, 'Helvetica Neue', Helvetica, sans-serif;">
                    <div style="font-size: 14px;line-height: 17px;color: #{options[:color]};font-family: Arial, 'Helvetica Neue', Helvetica, sans-serif;text-align: #{options[:text_align]};">
                      #{'<strong>' if options[:bold] == true}
                        <p style="margin: 0;font-size: #{options[:font_size]};line-height: 1">#{colorize_link(text)}</p>
                      #{'</strong>' if options[:bold] == true}
                    </div>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        HEREDOC
      end

      def card_activity_as_media_body(presented_activity)
        media_body = ''
        if presented_activity.author_fullname
          media_body << "<strong>#{presented_activity.author_fullname}</strong>&nbsp;"
        end

        media_body << colorize_link(presented_activity.description).html_safe
        media_body << "<br><small>#{presented_activity.timestamp}</small>"
        media_body
      end

      def media_left(left, body)
        <<~HEREDOC
          <table cellpadding="0" cellspacing="0" width="100%" style="border-spacing: 0;border-collapse: collapse;vertical-align: top">
            <tbody>
              <tr style="vertical-align: top">
                <td style="word-break: break-word;border-collapse: collapse !important;vertical-align: top;padding-top: 15px;padding-right: 5px;padding-bottom: 10px;padding-left: 10px">
                  #{left}
                </td>
                <td style="word-break: break-word;border-collapse: collapse !important;vertical-align: top;padding-top: 15px;padding-right: 5px;padding-bottom: 10px;padding-left: 5px">
                  <div style="color: #777777;line-height: 120%;font-family: Arial, 'Helvetica Neue', Helvetica, sans-serif;">
                    <div style="font-size: 14px;line-height: 17px;color: #777777;font-family: Arial, 'Helvetica Neue', Helvetica, sans-serif;text-align: left;">
                      <p style="margin: 0;font-size: 14px;line-height: 17px">#{body}</p>
                    </div>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        HEREDOC
      end

      def button(text, url)
        <<~HEREDOC
          <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-spacing: 0;border-collapse: collapse;vertical-align: top">
            <tbody>
              <tr style="vertical-align: top">
                <td class="button-container" align="left" style="word-break: break-word;border-collapse: collapse !important;vertical-align: top;padding-top: 15px;padding-right: 10px;padding-bottom: 10px;padding-left: 10px">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" style="border-spacing: 0;border-collapse: collapse;vertical-align: top">
                    <tbody>
                      <tr style="vertical-align: top">
                        <td width="100%" class="button" align="left" valign="middle" style="word-break: break-word;border-collapse: collapse !important;vertical-align: top">
                          <div align="left" style="display: inline-block; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; max-width: 25%; width: 100%; border-top: 0px solid transparent; border-right: 0px solid transparent; border-bottom: 0px solid transparent; border-left: 0px solid transparent;">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-spacing: 0;border-collapse: collapse;vertical-align: top;height: 42">
                              <tbody>
                                <tr style="vertical-align: top">
                                  <td valign="middle" style="word-break: break-word;border-collapse: collapse !important;vertical-align: top;border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; color: #ffffff; background-color: #C7702E; padding-top: 5px; padding-right: 20px; padding-bottom: 5px; padding-left: 20px; font-family: Arial, 'Helvetica Neue', Helvetica, sans-serif;text-align: center">
                                    <a href="#{url}" target="_blank" style="display: inline-block;text-decoration: none;-webkit-text-size-adjust: none;text-align: center;background-color: #C7702E;color: #ffffff">
                                      <span style="font-family:Arial, 'Helvetica Neue', Helvetica, sans-serif;font-size:16px;line-height:32px;">#{text}</span>
                                    </a>
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                          </div>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
            </tbody>
          </table>
        HEREDOC
      end

      def join_board_block(board)
        <<~HEREDOC
          <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-spacing: 0;border-collapse: collapse;vertical-align: top">
            <tbody>
              <tr style="vertical-align: top">
                <td class="button-container" align="center" style="word-break: break-word;border-collapse: collapse !important;vertical-align: top;padding-top: 15px;padding-right: 10px;padding-bottom: 10px;padding-left: 10px; background-color: #fff; border-radius: 3px;">
                <table cellpadding="0" cellspacing="0" width="100%" style="border-spacing: 0;border-collapse: collapse;vertical-align: top">
                  <tbody>
                    <tr style="vertical-align: top">
                      <td style="word-break: break-word;border-collapse: collapse !important;vertical-align: top;padding-top: 15px;padding-right: 10px;padding-bottom: 25px;padding-left: 10px">
                        <div style="color: #aaaaaa;line-height: 120%;font-family: Arial, 'Helvetica Neue', Helvetica, sans-serif;">
                          <div style="font-size: 14px;line-height: 17px;color: #aaaaaa;font-family: Arial, 'Helvetica Neue', Helvetica, sans-serif;text-align: center;">
                            <strong>
                              <p style="margin: 0;font-size: 27px;line-height: 17px">#{board.title}</p>
                            </strong>
                          </div>
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" style="border-spacing: 0;border-collapse: collapse;vertical-align: top">
                    <tbody>
                      <tr style="vertical-align: top">
                        <td width="100%" class="button" align="center" valign="middle" style="word-break: break-word;border-collapse: collapse !important;vertical-align: top">
                          <div align="center" style="display: inline-block; border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; width: auto; border-top: 0px solid transparent; border-right: 0px solid transparent; border-bottom: 0px solid transparent; border-left: 0px solid transparent;">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-spacing: 0;border-collapse: collapse;vertical-align: top;height: 42">
                              <tbody>
                                <tr style="vertical-align: top">
                                  <td valign="middle" style="word-break: break-word;border-collapse: collapse !important;vertical-align: top;border-radius: 5px; -webkit-border-radius: 5px; -moz-border-radius: 5px; color: #ffffff; background-color: #3FA450; padding-top: 5px; padding-right: 20px; padding-bottom: 5px; padding-left: 20px; font-family: Arial, 'Helvetica Neue', Helvetica, sans-serif;text-align: center">
                                      <span style="font-family: Arial, 'Helvetica Neue', Helvetica, sans-serif;font-size: 16px;line-height: 32px;">#{t('.see_the_board')}</span>
                                    </a>
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                          </div>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
            </tbody>
          </table>
        HEREDOC
      end

      private

      def colorize_link(html)
        html.gsub(/<a(.*)>/, '<a style="color: #3685B3;" \1>')
      end
    end
  end
end
