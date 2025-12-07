; ModuleID = '/home/gametime/test/lf-gametime-TCP2/server_reaction_function_1_analysis/server_reaction_function_1gt/server_reaction_function_1gt_linked.ll'
source_filename = "/home/gametime/test/lf-gametime-TCP2/server_reaction_function_1_analysis/server_reaction_function_1.c"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

%struct.packet = type { i32, i32, i32 }

; Function Attrs: noinline nounwind uwtable
define dso_local void @_serverreaction_function_1(ptr noundef %0, [2 x i64] %1) #0 {
  %3 = alloca %struct.packet, align 4
  %4 = alloca [2 x i64], align 8
  %5 = alloca ptr, align 8
  store [2 x i64] %1, ptr %4, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %3, ptr align 8 %4, i64 12, i1 false)
  store ptr %0, ptr %5, align 8
  ret void
}

; Function Attrs: alwaysinline nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

attributes #0 = { noinline nounwind uwtable "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #1 = { alwaysinline nocallback nofree nounwind willreturn memory(argmem: readwrite) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)"}
