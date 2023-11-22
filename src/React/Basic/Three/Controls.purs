module React.Basic.Three.Controls where

import React.Basic (JSX, ReactComponent, element)

foreign import orbitControls_ :: forall props. ReactComponent { | props }

orbitControls
  :: forall props
   . Record props
  -> JSX
orbitControls = element orbitControls_

