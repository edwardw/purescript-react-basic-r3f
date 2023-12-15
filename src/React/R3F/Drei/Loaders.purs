module React.R3F.Drei.Loaders where

import Prelude

import Effect.Uncurried (EffectFn1, runEffectFn1)
import React.Basic.Hooks (Hook, unsafeHook)
import React.R3F.Three.Types (Texture)

useTexture :: forall hooks. String -> Hook (UseLoader hooks) Texture
useTexture = unsafeHook <<< runEffectFn1 useTextureImpl

-- | A GLTF loader hook.
-- |
-- | The type is very liberal for now. A recommended and probably easier way to
-- | work with GLTFs is to use the tool `gltfjsx`, which converts and optionally
-- | compresses the models. It also generates a jsx import file such as:
-- |
-- | ```
-- |  export function Model(props) {
-- |    const { nodes, materials } = useGLTF('/path/to/glb-file')
-- |    return (
-- |      <group {...props} dispose={null}>
-- |        <mesh geometry={nodes.Object_4.geometry} material={materials['name1']} ... />
-- |        <mesh geometry={nodes.Object_5.geometry} material={materials['name2']} ... />
-- |        <... more meshes>
-- |      </group>
-- |    )
-- |  }
-- | ```
-- |
-- | which can roughly be translated to:
-- |
-- | ```
-- |  { nodes } <- useGLTF "/path/to/glb-file"
-- |  pure $ R3F.group
-- |    { children:
-- |        [ R3F.mesh nodes."Object_4"
-- |        , R3F.mesh nodes."Object_5"
-- |        , ...
-- |        ]
-- |    }
-- | ```
useGLTF :: forall hooks a. String -> Hook (UseLoader hooks) a
useGLTF = unsafeHook <<< runEffectFn1 useGLTFImpl

-- | An environment map loader.
-- |
-- | Usually in `hdr` or `exr` format.
useEnvironment :: forall hooks. String -> Hook (UseLoader hooks) Texture
useEnvironment file = unsafeHook $ runEffectFn1 useEnvImpl { files: file }

foreign import data UseLoader :: Type -> Type -> Type

foreign import useTextureImpl :: EffectFn1 String Texture
foreign import useGLTFImpl :: forall a. EffectFn1 String a
foreign import useEnvImpl :: forall props. EffectFn1 { | props } Texture
