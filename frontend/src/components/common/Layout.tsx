import React, { ReactNode } from "react";
import Container from "@mui/material/Container";
import { styled as mstyled } from "@mui/system";
import Header from "@components/common/Header";
import { IProps as IHeaderProps } from "@components/common/Header";

interface IProps {
  leftIcon: IHeaderProps["leftIcon"];
  children: ReactNode;
}

/**
 * Layout component는 헤더 및 theme을 포함하고 있다. 화면 비율에 맞춰 component를 넣으면 된다
 * @param props leftIcon: {@link @components/common/Header}, children
 * @returns Layout component
 *
 * @example
 * 화면 비율 조정하는 법
 * ```ts
 * // 컴포넌트 비율은 1:2
 * <Layout leftIcon="back">
 *   <div style={{ flex: 1}}></div>
 *   <div style={{ flex: 2}}></div>
 * </Layout>
 * ```
 */
export default function Layout(props: IProps) {
  return (
    <StyledContainer maxWidth="sm">
      <Header leftIcon={props.leftIcon} />
      {props.children}
    </StyledContainer>
  );
}

const StyledContainer = mstyled(Container)`
  background-color: white;
  display: flex;
  flex-direction: column;
  width: 39rem;
  height: 100vh;
  padding: 0 1.8rem;
`;