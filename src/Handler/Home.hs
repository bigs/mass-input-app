{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}

module Handler.Home where

import Import
import Yesod.Form.MassInput (massTable, inputList)

individualCommentForm :: Maybe Comment
                      -> AForm Handler Comment
individualCommentForm mComment =
  Comment <$>
    areq textField "Message" (commentMessage <$> mComment) <*>
    pure Nothing

massCommentForm :: Html -> MForm Handler (FormResult [Comment], Widget)
massCommentForm = renderTable $ inputList "Comments" massTable individualCommentForm Nothing

getHomeR :: Handler Html
getHomeR = do
  ((_, formWidget), formEnctype) <- runFormPost massCommentForm

  defaultLayout $ do
    $(widgetFile "home")

postHomeR :: Handler Html
postHomeR = do
  ((_, formWidget), formEnctype) <- runFormPost massCommentForm

  defaultLayout $ do
    $(widgetFile "home")
