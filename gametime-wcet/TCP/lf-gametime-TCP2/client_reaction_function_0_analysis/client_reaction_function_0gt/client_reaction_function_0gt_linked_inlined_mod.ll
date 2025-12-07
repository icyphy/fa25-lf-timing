; ModuleID = '/home/gametime/test/lf-gametime-TCP2/client_reaction_function_0_analysis/client_reaction_function_0gt/client_reaction_function_0gt_linked_inlined_mod.bc'
source_filename = "/home/gametime/test/lf-gametime-TCP2/client_reaction_function_0_analysis/client_reaction_function_0.c"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @_clientreaction_function_0(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = call i64 @time(ptr noundef null) #2
  %6 = trunc i64 %5 to i32
  call void @srand(i32 noundef %6) #2
  ret void
}

; Function Attrs: alwaysinline nounwind
declare void @srand(i32 noundef) #1

; Function Attrs: alwaysinline nounwind
declare i64 @time(ptr noundef) #1

attributes #0 = { noinline nounwind uwtable "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #1 = { alwaysinline nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)"}
