; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=powerpc64le-unknown-linux-gnu < %s | FileCheck %s

@g = private constant [4 x i32] [i32 122, i32 67, i32 35, i32 56]
@g2 = private constant [1 x i64] [i64 1], align 8

define void @test(ptr %p, ptr %p2) {
; CHECK-LABEL: test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addis 5, 2, .L_MergedGlobals@toc@ha
; CHECK-NEXT:    addi 5, 5, .L_MergedGlobals@toc@l
; CHECK-NEXT:    addi 6, 5, 12
; CHECK-NEXT:    std 6, 0(3)
; CHECK-NEXT:    addi 3, 5, 16
; CHECK-NEXT:    std 3, 0(4)
; CHECK-NEXT:    blr
  store ptr getelementptr inbounds ([4 x i32], ptr @g, i64 0, i64 1), ptr %p
  store ptr getelementptr inbounds ([4 x i32], ptr @g, i64 0, i64 2), ptr %p2
  ret void
}
